//
//  Plane.swift
//  ARTest
//
//  Created by Al Wold on 9/20/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import SceneKit
import ARKit
import os.log

class Plane: SCNNode {
    let plane: SCNBox
    var visible = false {
        didSet {
            updateColor()
        }
    }

    init(anchor: ARPlaneAnchor) {
        let width = CGFloat(anchor.extent.x)
        let length = CGFloat(anchor.extent.z)
        plane = SCNBox(width: width, height: 0.01, length: length, chamferRadius: 0.0)
        
        super.init()
        
        updateColor()
        self.geometry = plane
        self.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
        self.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Don't use this initializer")
    }
    
    func update(anchor: ARPlaneAnchor) {
        os_log("updating plane")
        let width = CGFloat(anchor.extent.x)
        let length = CGFloat(anchor.extent.z)
        plane.width = width
        plane.length = length
        self.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
    }
    
    func updateColor() {
        if visible {
            plane.firstMaterial!.diffuse.contents = UIColor(white: 0.6, alpha: 0.3)
        } else {
            plane.firstMaterial!.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        }
    }
}

