//
//  DeepARViewDelegate.swift
//  deep
//
//  Created by Matheus Silva on 13/02/20.
//  Copyright © 2020 Matheus Gois. All rights reserved.
//

import SceneKit
import ARKit

class DeepARViewDelegate: NSObject, ARSCNViewDelegate {
    weak var deepARScene: DeepARScene?
    
    func config(deepARScene: DeepARScene) {
        self.deepARScene = deepARScene
    }
        
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("Achou plano: \(node)")
        addPlane(planeAnchor: planeAnchor, node: node)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//        print("Atualizou plano")
//        updatePlane(planeAnchor: planeAnchor, node: node)
        
    }
    
    // MARK: - Add plane in anchor
    func addPlane(planeAnchor: ARPlaneAnchor, node: SCNNode)  {
        let width = CGFloat(0.1) // CGFloat(planeAnchor.extent.x)
        let height = CGFloat(0.1) // CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor.blue
        
        let planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
        planeNode.eulerAngles.x = -.pi / 2
        
        let deep = Deep()
        deep.setupDeath(deathPosition: SCNVector3(x, y, z))
        node.addChildNode(deep)
        node.addChildNode(planeNode)
    }
    
    func updatePlane(planeAnchor: ARPlaneAnchor, node: SCNNode) {
        guard let planeNode = node.childNodes.first, let plane = planeNode.geometry as? SCNPlane else { return }
        let width = CGFloat(0.1) // CGFloat(planeAnchor.extent.x)
        let height = CGFloat(0.1) // CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        
        planeNode.position = SCNVector3(x, y, z)
    }
}
