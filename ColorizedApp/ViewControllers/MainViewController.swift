//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Александра Лесовская on 19.03.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColorToView(with color: UIColor)
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SettingsViewController else { return }
        destination.color = view.backgroundColor
        destination.delegate = self
    }

}

extension MainViewController: SettingsViewControllerDelegate {
    func setColorToView(with color: UIColor) {
        view.backgroundColor = color
    }
}
