//
//  Deep.swift
//  deep
//
//  Created by Matheus Silva on 12/02/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import SceneKit

class Deep: SCNNode {
    let deathLocation = SCNVector3()
    override init() {
        super.init()
        name = "deep"
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
            child.name = "deep"
            nodeContainer.addChildNode(child)
        }
        
        addChildNode(nodeContainer)
    }

    func setPosition() {
      let maximo:Float = 1
      let minimo:Float = -1

      let x = Float.random(in: minimo...maximo) + minimo
      let y = Float.random(in: minimo...maximo) + minimo
      let z = Float.random(in: 0...4) - 2
     
      position = SCNVector3(1, 1, 1)
    }
    
    func setupDeath(deathPosition: SCNVector3) {
        let moveAction = SCNAction.move(to: deathPosition, duration: 5)
        let addAction = SCNAction.run({ _ in
            if let parent = self.parent {
                if let copyNode = self.copy() as? Deep {
                    copyNode.removeAllActions()
                    copyNode.setPosition()
                    copyNode.setupDeath(deathPosition: parent.position)
                    parent.addChildNode(copyNode)
                }
            }
        })
        let removeAction = SCNAction.removeFromParentNode()
        let sequence = SCNAction.sequence([moveAction, addAction, removeAction])
        runAction(sequence)
    }
}
