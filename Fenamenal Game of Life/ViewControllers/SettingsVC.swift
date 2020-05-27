//
//  SettingsVC.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/26/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var grid: Grid!
    var speedSlider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSpeedSlider()
        setupViews()
    }
    
    
    private func setupViews(){
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        speedSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speedSlider)
        view.backgroundColor = UIColor(white: 1, alpha: 0.25)

        NSLayoutConstraint.activate([
            speedSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            speedSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            speedSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            speedSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
    }
    
    private func configureSpeedSlider(){
        speedSlider.minimumValue = 0.03
        speedSlider.maximumValue = 2.0
        speedSlider.value = 1
        speedSlider.addTarget(self, action: #selector(speedsliderChanged), for: .valueChanged)
    }
    
    @objc func speedsliderChanged(){
        
    }

}
