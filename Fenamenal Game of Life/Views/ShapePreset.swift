//
//  ShapePreset.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

enum BrushType: String {
    case cell
    
    
}

class ShapePreset: UIView {

    var cellWidth: CGFloat
    var box = [[Cell]]()
    var view: UIView
    var presetView: UIView
    var size: Int
    init( size: Int, cellWidth: CGFloat, view: UIView, presetView: UIView) {
        self.size = size
        self.view = view
        self.presetView = presetView
        self.cellWidth = cellWidth
        super.init(frame: CGRect(x: 0, y: 0, width: Int(cellWidth) * size, height: Int(cellWidth) * size))
        self.backgroundColor = .white
        box = setupGrid()
    }
    var currentBrush: BrushType = .cell
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGrid() -> [[Cell]] {
            
        var grid = [[Cell]]()
        var gridColumn = [Cell]()
        for j in 0...(size - 1) {
            for i in 0...(size - 1) {
                let cell = Cell(frame: CGRect(x: cellWidth * CGFloat(j), y: cellWidth * CGFloat(i), width: cellWidth, height: cellWidth))

                cell.isUserInteractionEnabled = false
                addSubview(cell)
                
                gridColumn.append(cell)
            }
            grid.append(gridColumn)
            gridColumn.removeAll()
        }
        return grid
    }
    

    
}


