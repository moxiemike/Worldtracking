//
//  Navi.swift
//  Navi
//
//  Created by Joseph on 7/20/18.
//  Copyright © 2018 55B.ai. All rights reserved.

import ARKit
import UIKit
class Navi {

    //    resetOrigin: Reset local origin during live application usage
    //    Example: resetOrigin()
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration,options: [.resetTracking, .removeExistingAnchors])
    }
}
