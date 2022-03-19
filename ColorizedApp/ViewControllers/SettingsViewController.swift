//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Александра Лесовская on 05.03.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var redGreenBlueView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    // MARK: - Public Properties
    var color: UIColor!
    
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
            setTextFor(textFields: redColorTextField)
        case greenColorSlider:
            setTextFor(labels: greenColorLabel)
            setTextFor(textFields: greenColorTextField)
        default:
            setTextFor(labels: blueColorLabel)
            setTextFor(textFields: blueColorTextField)
        }
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let value = Float(text) else { return }
        switch sender {
        case redColorTextField:
            redColorSlider.setValue(value, animated: true)
            setTextFor(labels: redColorLabel)
        case greenColorTextField:
            greenColorSlider.setValue(value, animated: true)
            setTextFor(labels: greenColorLabel)
        default:
            blueColorSlider.setValue(value, animated: true)
            setTextFor(labels: blueColorLabel)
        }
        setColorToView()
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
    
    private func setTextFor(textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redColorTextField:
                redColorTextField.text = string(from: redColorSlider)
            case greenColorTextField:
                greenColorTextField.text = string(from: greenColorSlider)
            default:
                blueColorTextField.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

