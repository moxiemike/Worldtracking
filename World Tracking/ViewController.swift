//
//  ViewController.swift
//  World Tracking
//
//  Created by Joseph on 7/18/18.
//  Copyright © 2018 55B.ai. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
       
    @IBAction func add(_ sender: Any) {

//        Shape Cloud
        
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
       
//        Note: Use shape: Taurus or Cylinder for coins
//        node.geometry = SCNTorus(ringRadius: 0.10, pipeRadius: 0.03)
//        All shapes: https://developer.apple.com/documentation/scenekit/built_in_geometry_types
        //        Custom shapes: let shape = SCNShape(path: path, extrusionDepth: 0.1); node.geometry = shape

        
//        Random Positioning
        let x = randInRange(firstNum: -0.3, secondNum: 0.3)
        let y = randInRange(firstNum: -0.3, secondNum: 0.3)
        let z = randInRange(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(node)

//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x:0, y: 0.2))
//        path.addLine(to: CGPoint(x:0.2, y: 0.3))
//        path.addLine(to: CGPoint(x:0.4, y: 0.2))
//        path.addLine(to: CGPoint(x:0.4, y: 0))
//        let shape = SCNShape(path: path, extrusionDepth: 0.2)
//        node.geometry = shape
        
//        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
//        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
//        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
//
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        node.position = SCNVector3(0.2,0.3,-0.2)
//
//        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        cylinderNode.position = SCNVector3(-0.3,0.2,-0.3)
//        self.sceneView.scene.rootNode.addChildNode(node)
////        node.addChildNode(cylinderNode)
//
////        self.sceneView.scene.rootNode.addChildNode(cylinderNode)
//
//        boxNode.position = SCNVector3(0,-0.05,0)
//        node.addChildNode(cylinderNode)
//
//        doorNode.position = SCNVector3(0,-0.2,0.053)
//        boxNode.addChildNode(doorNode)
        
//        let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
//        pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        pyramid.position = SCNVector3(0,0,-0.3)
//        self.sceneView.scene.rootNode.addChildNode(pyramid)
//        pyramid.eulerAngles = SCNVector3(Float(90.degreesToRadians),0,0)
        
    }
    
    @IBAction func Reset(_ sender: Any) {
        self.restartSession()
    }
        
    
//    Navigation Functions
    
//    resetOrigin: Reset local origin during live application usage
//    Example: resetOrigin()
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration,options: [.resetTracking, .removeExistingAnchors])
    }
    
    
//    Math Functions
    
//    randInRange: Generate random number between two values
//    Example: randInRange(0,3)
    func randInRange(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random())/CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}


extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
