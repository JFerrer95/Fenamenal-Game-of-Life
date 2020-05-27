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
    var stackView = UIStackView()
    var cellColorButtons = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
    }
    
    init(grid: Grid){
        super.init(nibName: nil, bundle: nil)
        self.grid = grid
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        view.translatesAutoresizingMaskIntoConstraints = false
        speedSlider.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.50)
    
        configureSpeedSlider()
        configureStackView()
    }
    
    private func configureSpeedSlider(){
        view.addSubview(speedSlider)
        speedSlider.minimumValue = 0.03
        speedSlider.maximumValue = 2.0
        speedSlider.value = 1
        speedSlider.addTarget(self, action: #selector(speedsliderChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            speedSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            speedSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            speedSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            speedSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .horizontal
        configureStackViewConstraints()
        stackView.distribution = .fillEqually
        
        for i in 1...5 {
            let button = UIButton()
            switch i {
                case 1:
                    button.backgroundColor = .systemGreen
                case 2:
                    button.backgroundColor = .systemBlue
                case 3:
                    button.backgroundColor = .systemRed
                case 4:
                    button.backgroundColor = .black
                case 5:
                    button.backgroundColor = .clear
                    button.setImage(UIImage(systemName: "shuffle"), for: .normal)
                default:
                    button.backgroundColor = .black
            }
            stackView.addArrangedSubview(button)
        }
    }
    
    
    
    private func configureStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: speedSlider.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    @objc func speedsliderChanged(){
        grid?.speed = speedSlider.value
    }
    
}
