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
    var actualWidth: CGFloat
    var actualLength: CGFloat
    let plane: SCNBox
    var visible = false {
        didSet {
            updateColor()
        }
    }
    var isLowestPlane = false {
        didSet {
            updatePlaneSize()
        }
    }

    init(anchor: ARPlaneAnchor) {
        actualWidth = CGFloat(anchor.extent.x)
        actualLength = CGFloat(anchor.extent.z)
        plane = SCNBox(width: actualWidth, height: 0.01, length: actualLength, chamferRadius: 0.0)
        
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
        actualWidth = CGFloat(anchor.extent.x)
        actualLength = CGFloat(anchor.extent.z)
        plane.width = actualWidth
        plane.length = actualLength
        self.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
    }
    
    func updateColor() {
        if visible {
            if isLowestPlane {
                plane.firstMaterial!.diffuse.contents = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
            } else {
                plane.firstMaterial!.diffuse.contents = UIColor(white: 0.6, alpha: 0.3)
            }
        } else {
            plane.firstMaterial!.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        }
    }
    
    func updatePlaneSize() {
        if isLowestPlane {
            // make plane very large, so it covers the whole floor
            plane.width = 100
            plane.length = 100
            updateColor()
            physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: plane))
        } else {
            // set plane to its actual size
            plane.width = actualWidth
            plane.length = actualLength
            updateColor()
            physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: plane))
        }
    }
}

