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
        for i in 0...24 {
            for j in 0...24 {
                let cell = Cell(frame: CGRect(x: width / 25 * CGFloat(i), y: height / 2 - width / 2 + width / 25 * CGFloat(j), width: width / 25, height: width / 25), isAlive: false)
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
                if nextArray[x][y].isAlive == true {
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
                let neighbors = countNeighbors(matrix: screenArray, x: x, y: y)
                
                if state == false && neighbors == 3 {
                    nextArray[x][y].makeAlive()
                } else if state == true && (neighbors < 2 || neighbors > 3) {
                    nextArray[x][y].makeDead()
                } else {
                    
                    nextArray[x][y].isAlive = state
                }
            }
        }
        draw(matrix: nextArray)
    }
    
    func countNeighbors(matrix: [[Cell]], x: Int, y: Int) -> Int{
        var sum = 0
        for i in -1...1 {
            for j in -1...1{
                let col = (x + i + 25) % 25
                let row = (y + j + 25) % 25
                if matrix[col][row].isAlive {
                    sum += 1
                    
                }
            }
            
        }
        sum -= 1
        return sum
    }
    
}

