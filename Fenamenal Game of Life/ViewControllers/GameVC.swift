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
    let presetView = UIView()
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grid = Grid(width: self.view.frame.width, height: self.view.frame.height, view: self.view)
        settingsVC = SettingsVC(grid: grid)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTitle), name: .generationChanged, object: nil)
        configurePresetBar()
        setupPreset()
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
    
    func configurePresetBar() {
        presetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presetView)
        presetView.backgroundColor = .red
        NSLayoutConstraint.activate([
            presetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            presetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presetView.topAnchor.constraint(equalTo: grid.screenArray[24][24].bottomAnchor)
        ])
    }
    
    func setupPreset() {
        let preset = ShapePreset(frame: CGRect(x: presetView.center.x, y: presetView.center.y, width: grid.cellSize * 5, height: grid.cellSize * 5))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        preset.addGestureRecognizer(panGesture)
        presetView.addSubview(preset)
    }
    
    @objc private func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        guard let preset = panGesture.view as? ShapePreset else { return }
        
        let translation = panGesture.translation(in: self.view)
        panGesture.setTranslation(CGPoint.zero, in: self.view)
        
        switch(panGesture.state) {
            
        case .began:
            let point = CGPoint(x: preset.center.x + translation.x,
                                y: preset.center.y + translation.y)
            
            preset.center = point
        case .changed:
            
            let point = CGPoint(x: preset.center.x + translation.x,
                                y: preset.center.y + translation.y)
            preset.center = point
            
        case .ended:
            checkPlacement(preset)
            print("ended")
        case .cancelled:
            print("canceled pan")
        case .failed:
            print("failed pan")
        default:
            print("default")
        }
    }
    
    func checkPlacement(_ preset: ShapePreset) {
        
        for x in 0...24 {
            for y in 0...24 {
                if grid.screenArray[x][y].bounds.contains(preset.center) {
                    print("in")
                }
            }
        }
        
    }
    
}
