//
//  ViewController.swift
//  deep
//
//  Created by Matheus Silva on 04/11/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import QuartzCore

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let scene = SCNScene(named: "art.scnassets/scene.scn")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        
        configBlackHole()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func configBlackHole()
    {
        guard let holeScene = SCNScene(named: "art.scnassets/blackhole.scn") else { return }
        
        guard let blackhole_ring = holeScene.rootNode.childNode(withName: "Blackhole_ring", recursively: false) else { return }
        
        guard let blackhole_core = holeScene.rootNode.childNode(withName: "Blackhole_core", recursively: false) else { return }
        
        scene.rootNode.addChildNode(blackhole_ring)
        scene.rootNode.addChildNode(blackhole_core)
        
        for i in 1...3 {
            let str = "Blackhole_skin_0\(i)"
            guard let skin = holeScene.rootNode.childNode(withName: str, recursively: false) else { return }
            scene.rootNode.addChildNode(skin)
        }
    }
    

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    @objc
    func handleClick(_ gestureRecognizer: UIGestureRecognizer) {
        // retrieve the SCNView
        guard let scnView = self.view as? SCNView else { return }
        
        // check what nodes are clicked
        let p = gestureRecognizer.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            guard let material = result.node.geometry?.firstMaterial else { return }
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
}
