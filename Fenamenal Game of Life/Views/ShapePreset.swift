//
//  ShapePreset.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class ShapePreset: UIView {

    var box = [[Cell]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        box = setupGrid(width: frame.width, height: frame.height, view: self)
        setShape(shape: box)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGrid(width: CGFloat, height: CGFloat, view: UIView, isNext: Bool = false) -> [[Cell]] {
        
        var grid = [[Cell]]()
        var gridColumn = [Cell]()
        for j in 0...4 {
            for i in 0...4 {
                let cell = Cell(frame: CGRect(x: width / 5 * CGFloat(j), y: height / 2 - width / 2 + width / 5 * CGFloat(i), width: width / 5, height: width / 5), isAlive: false)
                cell.isUserInteractionEnabled = false
                if !isNext { view.addSubview(cell) }
                gridColumn.append(cell)
            }
            grid.append(gridColumn)
            gridColumn.removeAll()
        }
        return grid
    }
    
    func setShape(shape: [[Cell]]) {
        box[0][0].makeDead()
        box[2][1].makeAlive()
        box[1][2].makeAlive()
        box[2][2].makeAlive()
        box[3][2].makeAlive()
    }
    
}
