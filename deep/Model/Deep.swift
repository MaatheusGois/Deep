//
//  Deep.swift
//  deep
//
//  Created by Matheus Silva on 12/02/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import SceneKit

class Deep: SCNNode {
    func cerregarModelo() {
        let nodeContainer = SCNNode()
        guard let holeScene = SCNScene(named: "art.scnassets/blackhole.scn") else { return }
        for child in holeScene.rootNode.childNodes{
          nodeContainer.addChildNode(child)
        }
        addChildNode(nodeContainer)
    }

    func geraPosicoes() -> SCNVector3 {
      let maximo:Float = 5.0
      let minimo:Float = -5.0
     
      let eixoX = Float.random(in: minimo...maximo) + minimo
      let eixoY = Float.random(in: minimo...maximo) + minimo
      let eixoZ = Float.random(in: 0...4) - 2
     
      return SCNVector3(eixoX, eixoY, eixoZ)
    }
}
