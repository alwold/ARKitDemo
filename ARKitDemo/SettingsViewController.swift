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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDebugViewSwitch.isOn = Settings.shared.showDebugView
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender === showDebugViewSwitch {
            Settings.shared.showDebugView = sender.isOn
        }
    }
}
