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
        self.backgroundColor = .black
    }
    
    func changeState(){
        if isAlive == true {
            makeDead()
        } else {
            makeAlive()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeState()
    }
}
