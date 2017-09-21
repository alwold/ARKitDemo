//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Al Wold on 9/21/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import UIKit
import ARKit
import os.log

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate, SettingsDelegate {
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var debugView: UIView!
    @IBOutlet weak var planeCountLabel: UILabel!
    
    var planesByAnchorIdentifier = [UUID: Plane]()
    
    // MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        Settings.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        sceneView.session.delegate = self
        sceneView.session.run(configuration)
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let anchor = anchor as? ARPlaneAnchor {
            os_log("adding plane")
            let plane = Plane(anchor: anchor)
            if Settings.shared.showPlanes {
                plane.visible = true
            }
            node.addChildNode(plane)
            planesByAnchorIdentifier[anchor.identifier] = plane
            updateDebugView()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let anchor = anchor as? ARPlaneAnchor {
            os_log("got plane update")
            if let plane = planesByAnchorIdentifier[anchor.identifier] {
                os_log("found existing plane, updating it")
                plane.update(anchor: anchor)
                updateDebugView()
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        if let anchor = anchor as? ARPlaneAnchor {
            os_log("plane removed by ARKit")
            if let plane = planesByAnchorIdentifier.removeValue(forKey: anchor.identifier) {
                os_log("found the plane, removing it")
                plane.removeFromParentNode()
                updateDebugView()
            }
        }
    }
    
    // MARK: - Settings
    func showDebugViewChanged(to showDebugView: Bool) {
        debugView.isHidden = !showDebugView
    }
    
    func showPlanesChanged(to showPlanes: Bool) {
        for plane in planesByAnchorIdentifier.values {
            plane.visible = showPlanes
        }
    }
    
    // MARK: - Debug View
    func updateDebugView() {
        DispatchQueue.main.async {
            self.planeCountLabel.text = "Planes: \(self.planesByAnchorIdentifier.count)"
        }
    }
}
