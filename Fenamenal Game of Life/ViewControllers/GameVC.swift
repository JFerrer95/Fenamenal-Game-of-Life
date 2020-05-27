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
    var settingsVC = SettingsVC()
    var timer = Timer()
    var isRunning = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grid = Grid(width: self.view.frame.width, height: self.view.frame.height, view: self.view)
        title = "Fenamenal Game of Life"
    }
    
    
    
    @IBAction func buttonpressed(_ sender: Any) {
        grid.configureTimer()
    }

    @IBAction func settingsButtonPressed(_ sender: Any) {
        present(settingsVC, animated: true)
    }
    
}
