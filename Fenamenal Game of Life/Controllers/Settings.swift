//
//  Settings.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

enum CellColor: Int {
    case green = 1
    case blue
    case red
    case black
    case random
}

class Settings{

    static let shared = Settings()
    var cellColor: CellColor = .black {
        didSet{
            NotificationCenter.default.post(name: .didChangeCellColor, object: nil)
        }
    }

}


