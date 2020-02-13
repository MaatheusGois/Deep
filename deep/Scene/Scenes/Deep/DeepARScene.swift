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
    func config() {
        configScene()
        addDeep()
    }
    
    func configScene() {
        let scene = SCNScene(named: "art.scnassets/scene.scn")!
        self.scene = scene
    }
    
    func configDelegate() { }
    
    func addDeep() {
        let deep = Deep()
        deep.cerregarModelo()
        deep.position = deep.geraPosicoes()
        deep.name = "deep"
        scene.rootNode.addChildNode(deep)
    }
    func removeDeep() {
        if let deep = scene.rootNode.childNode(withName: "deep", recursively: false) {
            deep.removeFromParentNode()
        }
    }
}
