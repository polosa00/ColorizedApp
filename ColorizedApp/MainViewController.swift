//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Александр Полочанин on 11.04.23.
//

import UIKit

protocol ColorizedViewControllerDelegate {
    func  setValue(for color: UIColor)
}

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorizedVC = segue.destination as? ColorizedViewController else { return }
        colorizedVC.delegate = self
        colorizedVC.colorForView = view.backgroundColor
    }
}

extension MainViewController: ColorizedViewControllerDelegate {
    func setValue(for color: UIColor) {
        view.backgroundColor = color
    }
}
