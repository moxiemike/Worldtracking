//
//  ViewController.swift
//  Planets
//
//  Created by Joseph on 7/22/18.
//  Copyright © 2018 55B.ai. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let scaleFactor = 0.1
        
        //Build Planets
        let sun = planet(geometry: SCNSphere(radius: CGFloat(0.35*scaleFactor)), diffuse: UIImage(named:"Sun")!, specular: nil, normal: nil, emission: nil, position: SCNVector3(0,0,-1*scaleFactor))
        let earth = planet(geometry: SCNSphere(radius: CGFloat(0.2*scaleFactor)), diffuse: UIImage(named:"Earth Day")!, specular: UIImage(named:"Earth Specular"), normal: UIImage(named:"Earth Normal"), emission: UIImage(named:"Earth Emission"), position: SCNVector3(1.2*scaleFactor,0,0))
        let venus = planet(geometry: SCNSphere(radius: CGFloat(0.1*scaleFactor)), diffuse: UIImage(named:"Venus")!, specular: nil, normal: nil, emission: nil, position: SCNVector3(0.7*scaleFactor,0,0))
        let moon = planet(geometry: SCNSphere(radius: CGFloat(0.05*scaleFactor)), diffuse: UIImage(named:"Moon")!, specular: nil, normal: nil, emission: nil, position: SCNVector3(0,0,-0.3*scaleFactor))
        
        //Define Rotating Objects
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        //Define Rotating Children and the Rotating b/w Objects
        earthParent.addChildNode(earth) //earth object rotates around (0,0,-1), (sun origin)
        earth.addChildNode(moon) //moon object rotates around (1.2,0,0), (earth origin)
        earthParent.addChildNode(moonParent) //Rotation around sun
        moonParent.addChildNode(moon) //Rotation around earth
        venusParent.addChildNode(venus) //Rotation around sun
        
        //Set Rotation Origin
        earthParent.position = SCNVector3(0,0,-1*scaleFactor)
        venusParent.position = SCNVector3(0,0,-1*scaleFactor)
        moonParent.position = SCNVector3(1.2*scaleFactor,0,0)
        
        //Add Objects to sceneView
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent) //Moon is a child of earthParent
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        //Define Rotation Time
        let slowdownFactor = 1
        let sunAction = Rotation(time: TimeInterval(27*slowdownFactor))
        let earthParentRotation = Rotation(time: TimeInterval(37*slowdownFactor)) //Rotation time around sun
        let venusParentRotation = Rotation(time: TimeInterval(23*slowdownFactor))
        let earthRotation = Rotation(time: TimeInterval(365*slowdownFactor)) //Rotation time around itself
        let moonRotation = Rotation(time: TimeInterval(27*slowdownFactor))
        let venusRotation = Rotation(time: TimeInterval(116*slowdownFactor))

        //Run Rotation Action
        //Note. This code snippet can be combined w/ previous code snippet, i.e.: earth.runAction(earthRotation) = earth.runAction(Rotation(time: 8).
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        moonParent.runAction(moonRotation)
        sun.runAction(sunAction)

    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, normal: UIImage?, emission: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.deg2rad), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
}

extension Int {
    
    var deg2rad: Double { return Double(self) * .pi/180}
}
