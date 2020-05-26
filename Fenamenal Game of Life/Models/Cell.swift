//
//  Cell.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/22/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit



class Cell: UIView {
    var isAlive: Bool = false
    
    init(frame: CGRect, isAlive: Bool = false ) {
        super.init(frame: frame)
        self.isAlive = isAlive
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .white
    
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
    }
    
    func makeDead() {
        self.isAlive = false
        self.backgroundColor = .white
    }
    
    func makeAlive() {
        self.isAlive = true
        let randomColorNum = Int.random(in: 1...4)
        switch randomColorNum {
        case 1:
            backgroundColor = UIColor.yellow
        case 2:
            backgroundColor = UIColor.red
        case 3:
            backgroundColor = UIColor.blue
        case 4:
            backgroundColor = UIColor.green
        default:
            backgroundColor = UIColor.black
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isAlive == false {
            makeAlive()
        } else {
            makeDead()
        }
    }
}
