//
//  Ball.swift
//  ARTest
//
//  Created by Al Wold on 9/21/17.
//  Copyright © 2017 Al Wold. All rights reserved.
//

import SceneKit
import ARKit

class Ball: SCNNode {
    static let ballDropHeight: Float = 2.0
    
    init(position: SCNVector3, color: UIColor = .random()) {
        super.init()
        geometry = SCNSphere(radius: 0.1)
        geometry!.firstMaterial!.diffuse.contents = color
        self.position = position
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    }
    
    convenience init(hitPosition: SCNVector3) {
        var ballPosition = hitPosition
        ballPosition.y += Ball.ballDropHeight
        self.init(position: ballPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Unarchiving not supported")
    }
}

