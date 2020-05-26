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
        
    }
    func setupNextArray() -> [[Cell]] {
        var nextArray = [[Cell]]()
        var gridColumn = [Cell]()
        for j in 0...24 {
            for i in 0...24 {
                let cell = Cell(frame: CGRect(x: width / 25 * CGFloat(j), y: height / 2 - width / 2 + width / 25 * CGFloat(i), width: width / 25, height: width / 25), isAlive: false)
                view.addSubview(cell)
                gridColumn.append(cell)
            }
            nextArray.append(gridColumn)
            gridColumn.removeAll()
        }
        return nextArray
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
        screenArray = matrix
    }
    
    func computeNext(){
        var nextArray = setupNextArray()
        
        for x in 0...24 {
            for y in 0...24 {
                let state = screenArray[x][y].isAlive
                let neighbors = countNeighbors(x: x, y: y)
                
                if screenArray[x][y].isAlive == true {
                    if neighbors == 2 || neighbors == 3 {
                        nextArray[x][y].makeAlive()
                    } else {
                        nextArray[x][y].makeDead()
                    }
                } else {
                    if neighbors == 3 {
                        nextArray[x][y].makeAlive()
                    }
                }
            }
        }
        
        draw(matrix: nextArray)
    }
    
    func countNeighbors( x: Int, y: Int) -> Int{
        var count = 0
        let rows = 25
        
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                if (i == x && j == y) || (i >= rows) || (j >= rows) || ( i < 0 ) || (j < 0) {
                    continue
                }
                
                if screenArray[i][j].isAlive { count += 1}
            }
        }

        return count
    }
    
}

