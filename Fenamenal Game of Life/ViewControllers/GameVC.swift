//
//  GameVC.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/22/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    //MARK: - Properties
    var grid: Grid!
    var settingsVC: SettingsVC!
    var timer = Timer()
    var isRunning = false
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grid = Grid(width: self.view.frame.width, height: self.view.frame.height, view: self.view)
        settingsVC = SettingsVC(grid: grid)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTitle), name: .generationChanged, object: nil)
        
    }
    
    @objc func updateTitle(_ notification: NSNotification ) {
        if let dict = notification.userInfo {
            if let id = dict["generations"] as? Int {
                if id == 0{
                    title = "Fenamenal Game of Life"
                } else {
                    title = "\(id) Generations"
                }
            }
        }
    }
    @IBAction func buttonpressed(_ sender: UIBarButtonItem) {
        if isRunning == false {
            isRunning = true
            sender.image = UIImage(systemName: "pause.circle")
            nextButton.isEnabled = false
        } else {
            isRunning = false
            sender.image = UIImage(systemName: "play.circle")
            nextButton.isEnabled = true
        }
        grid.configureTimer()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        if isRunning == false {
            grid.computeNext()
            grid.generations += 1
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        present(settingsVC, animated: true)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        grid.resetGame()
    }
    

    
}
