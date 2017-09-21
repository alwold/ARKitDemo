//
//  Settings.swift
//  ARKitDemo
//
//  Created by Al Wold on 9/21/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import Foundation

protocol SettingsDelegate: class {
    func showDebugViewChanged(to: Bool)
}

class Settings {
    static let shared = Settings()
    
    weak var delegate: SettingsDelegate?
    
    var showDebugView = false {
        didSet {
            delegate?.showDebugViewChanged(to: showDebugView)
        }
    }
}
