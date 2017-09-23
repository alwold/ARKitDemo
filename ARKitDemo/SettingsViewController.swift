//
//  SettingsViewController.swift
//  ARKitDemo
//
//  Created by Al Wold on 9/21/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var showDebugViewSwitch: UISwitch!
    @IBOutlet weak var showPlanesSwitch: UISwitch!
    @IBOutlet weak var applyButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDebugViewSwitch.isOn = Settings.shared.showDebugView
        showPlanesSwitch.isOn = Settings.shared.showPlanes
        
        // hide apply button if device is iPad
        applyButton.isHidden = (UIDevice.current.model == "iPad")
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender === showDebugViewSwitch {
            Settings.shared.showDebugView = sender.isOn
        } else if sender === showPlanesSwitch {
            Settings.shared.showPlanes = sender.isOn
        }
    }
    @IBAction func applyButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
