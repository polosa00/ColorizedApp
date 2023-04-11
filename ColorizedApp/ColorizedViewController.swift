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
        
        let ciColor = CIColor(color: colorForView)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
        
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)

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
    
    private func setColor() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension ColorizedViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
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
}


    





