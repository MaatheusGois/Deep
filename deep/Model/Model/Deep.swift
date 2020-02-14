//
//  Deep.swift
//  deep
//
//  Created by Matheus Silva on 12/02/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import SceneKit

class Deep: SCNNode {
    
    override init() {
        super.init()
        loadModel()
        setPosition()
        setupDeath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadModel() {
        let nodeContainer = SCNNode()
        guard let holeScene = SCNScene(named: "art.scnassets/blackhole.scn") else { return }
        for child in holeScene.rootNode.childNodes{
          nodeContainer.addChildNode(child)
        }
        addChildNode(nodeContainer)
    }

    func setPosition() {
//      let maximo:Float = 5.0
//      let minimo:Float = -5.0
//
//      let eixoX = Float.random(in: minimo...maximo) + minimo
//      let eixoY = Float.random(in: minimo...maximo) + minimo
//      let eixoZ = Float.random(in: 0...4) - 2
     
      position = SCNVector3(1, 1, 1)
    }
    
    func setupDeath() {
        let initalPosition = SCNVector3(0, 0, 0)
        let action = SCNAction.move(to: initalPosition, duration: 30)
        let actionRemove = SCNAction.removeFromParentNode()
        let sequence = SCNAction.sequence([action, actionRemove])
        runAction(sequence)
    }
}
