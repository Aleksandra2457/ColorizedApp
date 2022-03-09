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
        setColorToView()
    }
    
    // MARK: - Public Methods
    @IBAction func sliderValueChanged(_ slider: UISlider) {
        setColorToView()
        switch slider {
        case redColorSlider:
            setTextFor(labels: redColorLabel)
        case greenColorSlider:
            setTextFor(labels: greenColorLabel)
        default:
            setTextFor(labels: blueColorLabel)
        }
    }
    
    // MARK: - Private Methods
    private func setColorToView() {
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
    
    private func setTextFor(labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel:
                redColorLabel.text = string(from: redColorSlider)
            case greenColorLabel:
                greenColorLabel.text = string(from: greenColorSlider)
            default:
                blueColorLabel.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

