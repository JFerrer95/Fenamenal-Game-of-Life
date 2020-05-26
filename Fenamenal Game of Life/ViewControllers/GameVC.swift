//
//  GameVC.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/22/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    var grid: Grid!
    var timer = Timer()
    var isRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grid = Grid(width: self.view.frame.width, height: self.view.frame.height, view: self.view)
        
    }
    
    func runLife() {
        grid.computeNext()
    }
    @IBAction func buttonpressed(_ sender: Any) {
        if isRunning {
            timer.invalidate()
            view.isUserInteractionEnabled = true
            
        } else {
            view.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
                self.runLife()
            })
        }
        isRunning.toggle()
    }


}
