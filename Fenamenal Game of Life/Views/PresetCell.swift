//
//  PresetCell.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/27/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class PresetCell: UITableViewCell {
    
    static var identifier: String = "PresetCell"
    
    var preset: ShapePreset!
    var label = UILabel()
    
    func set(preset: ShapePreset ) {
        translatesAutoresizingMaskIntoConstraints = false
        self.preset = preset
        label.text = preset.currentBrush.rawValue.capitalized
        label.translatesAutoresizingMaskIntoConstraints = false
        preset.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        self.contentView.addSubview(preset)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            preset.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            preset.topAnchor.constraint(equalTo: contentView.topAnchor),
            preset.heightAnchor.constraint(equalToConstant: preset.frame.height),
            preset.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            preset.widthAnchor.constraint(equalToConstant: contentView.frame.width / 25 * 5),
            
            contentView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 25 * 5 + 16)
        ])
   
    }

    func select() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.yellow.cgColor
    }

}
