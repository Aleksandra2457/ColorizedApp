//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Александра Лесовская on 05.03.2022.
//

import UIKit

class RedGreenBlueViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var redGreenBlueView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        redGreenBlueView.layer.cornerRadius = 15
        updateUserInterface()
    }
    
    // MARK: - Public Methods
    @IBAction func sliderValueChanged() {
        updateUserInterface()
    }
    
    // MARK: - Private Methods
    private func updateUserInterface() {
        redColorLabel.text = String(format: "%.2f", redColorSlider.value)
        greenColorLabel.text = String(format: "%.2f", greenColorSlider.value)
        blueColorLabel.text = String(format: "%.2f", blueColorSlider.value)
        let redColor = CGFloat(redColorSlider.value)
        let greenColor = CGFloat(greenColorSlider.value)
        let blueColor = CGFloat(blueColorSlider.value)
        redGreenBlueView.backgroundColor = UIColor(
            red: redColor,
            green: greenColor,
            blue: blueColor,
            alpha: 1
        )
    }
    
}

