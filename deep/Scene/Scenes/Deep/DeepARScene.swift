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
    
    func reset() {
        session.pause()
        if let configuration = session.configuration {
            session.run(configuration,
                                  options: [.removeExistingAnchors,
                                  .resetTracking])
        }
    }
    
    func automaticallyLigh() {
        autoenablesDefaultLighting = true
        automaticallyUpdatesLighting = true
    }
    
    // MARK: - DEEP
    func addDeep(node: SCNNode) {
        let deep = Deep()
        deep.setupDeath(deathPosition: node.position)
        node.addChildNode(deep)
    }
    func updateDeep(deathPosition: SCNVector3) {
        if let deep = scene.rootNode.childNode(withName: "deep", recursively: false) {
            deep.position = deathPosition
        }
        
    }
    func removeDeep(deep: SCNNode) {
        deep.removeFromParentNode()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentTouchLocation = touches.first?.location(in: self),
        let hitTestNode = hitTest(currentTouchLocation, options: nil).first?.node
        else { return }
        if hitTestNode.name == "deep", let parent = hitTestNode.parent?.parent?.parent {
            hitTestNode.removeAllActions()
            removeDeep(deep: hitTestNode)
            addDeep(node: parent)
            ImpactFeedback.shared.generateHeavy()
        }
    }
}
