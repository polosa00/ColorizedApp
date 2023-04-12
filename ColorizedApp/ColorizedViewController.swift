//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Александр Полочанин on 25.03.23.
//

import UIKit

final class ColorizedViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var colorizedView: UIView!
    
    @IBOutlet private var redValueLabel: UILabel!
    @IBOutlet private var greenValueLabel: UILabel!
    @IBOutlet private var blueValueLabel: UILabel!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var colorForView: UIColor!
    
    var delegate: ColorizedViewControllerDelegate!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorizedView.backgroundColor = colorForView
        
        setSliderValue()
        setTextForLabelAndTF()
        setDoneButton(for: [redTextField, greenTextField, blueTextField])
    }
    
    // MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        delegate.setValue(for: colorizedView.backgroundColor ?? .red)
        dismiss(animated: true)
    }
    
    @IBAction func changedColor(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redValueLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenValueLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueValueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    // MARK: - Override methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        setColor()
        setTextForLabelAndTF()
    }
}
// MARK: - Text Field Delegate
extension ColorizedViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text, !newValue.isEmpty else {
            showAlert(withTitle: "Text field is empty ", andMessage: "Enter data!")
            return
        }
        guard let numberValue = Float(newValue) else { return }
        
        if numberValue < 0 || numberValue > 1 {
            showAlert(withTitle: "Incorrect value", andMessage: "Input value from 0 to 1")
            redSlider.setValue(1, animated: true)
            greenSlider.setValue(1, animated: true)
            blueSlider.setValue(1, animated: true)
            setColor()
            setTextForLabelAndTF()
        }
        
        if textField == redTextField {
            redSlider.setValue(numberValue, animated: true)
            redTextField.text = string(from: redSlider)
        } else if textField == greenTextField {
            greenSlider.setValue(numberValue, animated: true)
        } else if textField == blueTextField {
            blueSlider.setValue(numberValue, animated: true)
        }
        setColor()
    }
   
    private func setDoneButton(for textFields: [UITextField]) {
        textFields.forEach { textField in
            let keyboardToolbar = UIToolbar()
            textField.inputAccessoryView = keyboardToolbar
            keyboardToolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(didTapDone)
            )
            let flexBurButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            
            keyboardToolbar.items = [doneButton, flexBurButton]
        }
        
    }
    @objc private func didTapDone() {
        view.endEditing(true)
        setColor()
        setTextForLabelAndTF()
    }
}
// MARK: - Private methods
extension ColorizedViewController {
    private func setColor() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setSliderValue() {
        let ciColor = CIColor(color: colorForView)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func setTextForLabelAndTF() {
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(withTitle title: String,andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

    





