//
//  UIColor+Ext.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

extension UIColor {
    func getRandomColor() -> UIColor {
        let randomNum = Int.random(in: 1...4)
        switch randomNum {
        case 1:
            return UIColor.yellow
        case 2:
             return UIColor.red
        case 3:
            return UIColor.blue
        case 4:
            return UIColor.green
        default:
            return UIColor.black
        }
    }
}
