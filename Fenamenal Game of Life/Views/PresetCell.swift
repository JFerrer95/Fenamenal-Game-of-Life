//
//  PresetCell.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class PresetCell: UICollectionViewCell {
    
    static var identifier: String = "PresetCell"
    
    var preset: ShapePreset!
    
    func set(preset: ShapePreset ) {
        self.preset = preset

        self.contentView.addSubview(preset)

   
    }

    func select() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.yellow.cgColor
    }

}
