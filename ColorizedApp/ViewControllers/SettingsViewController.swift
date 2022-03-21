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
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Private Properties
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    private var alpha: CGFloat = 1
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        redGreenBlueView.layer.cornerRadius = 15
        updateUI()
        createToolBarWithDoneButton()
    }
    
    // MARK: - IB Actions
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
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        color = redGreenBlueView.backgroundColor
        delegate.setColorToView(with: color)
        dismiss(animated: true)
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
            alpha: alpha
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
    
    private func getRGBColor() {
        guard let color = color else { return }
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
    private func setValueForSliders() {
        redColorSlider.value = Float(red)
        greenColorSlider.value = Float(green)
        blueColorSlider.value = Float(blue)
    }
    
    private func updateUI() {
        getRGBColor()
        setValueForSliders()
        setColorToView()
        setTextFor(labels: redColorLabel, greenColorLabel, blueColorLabel)
        setTextFor(textFields: redColorTextField, greenColorTextField, blueColorTextField)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

    // MARK: - Keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    // hiding the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty != nil,
              let text = textField.text,
              let value = Float(text),
              value >= 0.0 && value <= 1.0 else {
            showAlert(
                title: "Error 🥲",
                message: "Please enter value from 0.00 to 1.00",
                textField: textField)
            return
        }
        switch textField {
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

    @objc func doneBarButtonPressed() {
        view.endEditing(true)
    }
    
    private func createToolBarWithDoneButton() {
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneBarButtonPressed)
        )
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([space, doneButton], animated: false)
        
        redColorTextField.inputAccessoryView = toolbar
        greenColorTextField.inputAccessoryView = toolbar
        blueColorTextField.inputAccessoryView = toolbar
    }
}

    // MARK: - Create Alert To Show
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
