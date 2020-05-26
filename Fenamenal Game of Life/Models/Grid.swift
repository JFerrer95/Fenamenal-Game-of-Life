//
//  GameState.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/22/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class Grid {
    
    var screenArray = [[Cell]]()
    var nextArray = [[Cell]]()
    var width: CGFloat!
    var height: CGFloat!
    var view: UIView!
    init(width: CGFloat, height: CGFloat, view: UIView) {
        self.width = width
        self.height = height
        self.view = view
        setupArray()
    }
    
    
    func setupArray() {
        var gridColumn = [Cell]()
        for j in 0...24 {
            for i in 0...24 {
                let cell = Cell(frame: CGRect(x: width / 25 * CGFloat(j), y: height / 2 - width / 2 + width / 25 * CGFloat(i), width: width / 25, height: width / 25), isAlive: false)
                view.addSubview(cell)
                gridColumn.append(cell)
            }
            screenArray.append(gridColumn)
            gridColumn.removeAll()
        }
        nextArray = screenArray
    }
    
    func draw(matrix: [[Cell]]) {
        
        
        
        for x in 0...24 {
            for y in 0...24 {
                if matrix[x][y].isAlive == true {
                    screenArray[x][y].makeAlive()
                } else {
                    screenArray[x][y].makeDead()
                    
                }
            }
        }
    }
    
    func computeNext(){
        for x in 0...24 {
            for y in 0...24 {
                let state = screenArray[x][y].isAlive
                let neighbors = countNeighbors(x: x, y: y)

                if state == true {
                    if neighbors <= 1 {
                        nextArray[x][y].makeDead()
                    } else if neighbors >= 4 {
                        nextArray[x][y].makeDead()
                    } else {
                        nextArray[x][y].makeAlive()
                    }
                } else {
                    if neighbors == 3 {
                        nextArray[x][y].makeAlive()
                    } else {
                        nextArray[x][y].makeDead()
                    }
                }
            }
        }
        
        draw(matrix: nextArray)
    }
    
    func countNeighbors( x: Int, y: Int) -> Int{
        var count = 0
        let rows = 25
        let cols = 25
        if (x - 1 >= 0) {
            if (screenArray[x - 1][y].isAlive ) { count += 1 }
        }
        if (x - 1 >= 0 && y - 1 >= 0) {
            if (screenArray[x - 1][y - 1].isAlive) {count += 1 }
        }
        if (x - 1 >= 0 && y + 1 < cols) {
            if (screenArray[x - 1][y + 1].isAlive){ }
        }
        if (y - 1 >= 0) {
            if (screenArray[x][y - 1].isAlive){ count += 1}
        }
        if (y + 1 < cols) {
            if (screenArray[x][y + 1].isAlive) {count += 1}
        }
        if (x + 1 < rows) {
            if (screenArray[x + 1][y].isAlive) {count += 1}
        }
        if (x + 1 < rows && y - 1 >= 0) {
            if (screenArray[x + 1][y - 1].isAlive) { count += 1}
        }
        if (x + 1 < rows && y + 1 < cols) {
            if (screenArray[x + 1][y + 1].isAlive) { count += 1}
        }
        

        
        
        
        
        
        
        return count
    }
    
}

