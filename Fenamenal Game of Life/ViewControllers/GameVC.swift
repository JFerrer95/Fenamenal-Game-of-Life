//
//  GameVC.swift
//  Fenamenal Game of Life
//
//  Created by jonathan ferrer on 5/22/20.
//  Copyright © 2020 Jonathan Ferrer. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    //MARK: - Properties
    var grid: Grid!
    var settingsVC: SettingsVC!
    var timer = Timer()
    var isRunning = false
    let presetView = UIView()
    var presetCollectionView: UICollectionView!
    
    
    var label = UILabel()
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        grid = Grid(width: self.view.frame.width, height: self.view.frame.height, view: self.view)
        settingsVC = SettingsVC(grid: grid)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTitle), name: .generationChanged, object: nil)
        configurePresetBar()
        setupPreset()
        setupCollectionView()
        configureCurrentPresetLabel()
        configurePresets()
    }
    
    @objc func updateTitle(_ notification: NSNotification ) {
        if let dict = notification.userInfo {
            if let id = dict["generations"] as? Int {
                if id == 0{
                    title = "Fenamenal Game of Life"
                } else {
                    title = "\(id) Generations"
                }
            }
        }
    }
    @IBAction func buttonpressed(_ sender: UIBarButtonItem) {
        if isRunning == false {
            isRunning = true
            sender.image = UIImage(systemName: "pause.circle")
            nextButton.isEnabled = false
        } else {
            isRunning = false
            sender.image = UIImage(systemName: "play.circle")
            nextButton.isEnabled = true
        }
        grid.configureTimer()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
        if isRunning == false {
            grid.computeNext()
            grid.generations += 1
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        present(settingsVC, animated: true)
    }
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        grid.resetGame()
    }
    
    func configureCurrentPresetLabel() {
        label.text = "Current Brush: Dot"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
    func configureCurrentPresetView(index: Int) {
        if grid.currentPreset != nil { grid.currentPreset.removeFromSuperview() }
        let selectedPreset = grid.presets[index]
        let preset = ShapePreset(size: selectedPreset.size, cellWidth: selectedPreset.cellWidth, brushType: selectedPreset.currentBrush)
        grid.currentPreset = preset
        preset.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preset)
        
        NSLayoutConstraint.activate([
            preset.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            preset.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -preset.frame.width / 2)
        ])
        
        label.text = "Current Brush: " + grid.currentPreset.currentBrush.rawValue.capitalized
    }
    

    
    func configurePresetBar() {
        presetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presetView)
        presetView.backgroundColor = .red
        NSLayoutConstraint.activate([
            presetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            presetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presetView.topAnchor.constraint(equalTo: grid.screenArray[24][24].bottomAnchor)
        ])
    }
    
    func setupPreset() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.presetView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.presetView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.presetView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.presetView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.presetCollectionView = collectionView
    }
    
    func setupCollectionView() {
        self.presetCollectionView.dataSource = self
        self.presetCollectionView.delegate = self
        self.presetCollectionView.register(PresetCell.self, forCellWithReuseIdentifier: PresetCell.identifier)
        self.presetCollectionView.backgroundColor = .white
        self.presetCollectionView.allowsSelection = true
        
    }
    

    
    func configurePresets() {
        grid.presets.append(ShapePreset(size: 1, cellWidth: grid.cellSize, brushType: .dot))
        grid.presets.append(ShapePreset(size: 3, cellWidth: grid.cellSize, brushType: .blinker))
        grid.presets.append(ShapePreset(size: 3, cellWidth: grid.cellSize, brushType: .glider))
        grid.presets.append(ShapePreset(size: 4, cellWidth: grid.cellSize, brushType: .beacon))
    }
    

    
}

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid.presets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PresetCell.identifier, for: indexPath) as! PresetCell
        let preset = grid.presets[indexPath.item]
        cell.set(preset: preset)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        configureCurrentPresetView(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: grid.cellSize * 6, height: grid.cellSize * 6)
    }
    
}
