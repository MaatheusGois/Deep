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
      let maximo:Float = 5.0
      let minimo:Float = -5.0

      let x = Float.random(in: minimo...maximo) + minimo
      let y = Float.random(in: minimo...maximo) + minimo
      let z = Float.random(in: 0...4) - 2
     
      position = SCNVector3(x, y, z)
    }
    
    func setupDeath(deathPosition: SCNVector3) {
        let action = SCNAction.move(to: deathPosition, duration: 5)
        let actionRemove = SCNAction.removeFromParentNode()
        let sequence = SCNAction.sequence([action, actionRemove])
        runAction(sequence)
    }
}
