//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Александр Полочанин on 25.03.23.
//

import UIKit

final class ColorizedVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var colorizedView: UIView!
    
    @IBOutlet private var redValueLabel: UILabel!
    @IBOutlet private var greenValueLabel: UILabel!
    @IBOutlet private var blueValueLabel: UILabel!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = 0.05
        greenSlider.value = 0.27
        blueSlider.value = 0.49
        
        setColorForView()
        setValueForLabels()
    }
    
    // MARK: - IBActions
    
    @IBAction private func changedRGBColor() {
        setColorForView()
        setValueForLabels()
    }
}

    // MARK: - Setup color and value for label

extension ColorizedVC {
    private func setColorForView() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValueForLabels() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}



