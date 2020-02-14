//
//  DeepScene.swift
//  deep
//
//  Created by Matheus Silva on 13/02/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import SceneKit
import ARKit


class DeepARScene: ARSCNView {
    let deepARSceneDelegate = DeepARViewDelegate()
    
    func config() {
        configDelegate()
        configScene()
        automaticallyLigh()
    }
    
    func configScene() {
        let scene = SCNScene(named: "art.scnassets/scene.scn")!
        self.scene = scene
    }
    
    func configDelegate() {
        delegate = deepARSceneDelegate
        deepARSceneDelegate.config(deepARScene: self)
    }
    
    func debug() {
        showsStatistics = true
        debugOptions = [.showFeaturePoints]
    }
    
    func automaticallyLigh() {
        autoenablesDefaultLighting = true
        automaticallyUpdatesLighting = true
    }
    
    // MARK: - DEEP
    func addDeep() {
        let deep = Deep()
        scene.rootNode.addChildNode(deep)
    }
    func removeDeep() {
        if let deep = scene.rootNode.childNode(withName: "deep", recursively: false) {
            deep.removeFromParentNode()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
            let hitTestTouch = hitTest(touch.location(in: self), types: .existingPlaneUsingExtent).first {
            let local = touch.location(in: self)
            let objTouched = hitTest(local, options: nil)
            
            //set anchor
            let anchor = ARAnchor(transform: hitTestTouch.worldTransform)
            session.add(anchor: anchor)
            if let deepTouched = objTouched.first {
                let deep = deepTouched.node
                for i in 0...4 {
                    if deep.name == "Blackhole_\(i)" {
                        removeDeep()
                        addDeep()
                        ImpactFeedback.shared.generateHeavy()
                        break
                    }
                }
                
            }
            
        }
    }
}
