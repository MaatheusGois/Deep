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

class DeepViewController: UIViewController {
    @IBOutlet var sceneView: DeepARScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let local = touch.location(in: sceneView)
            let objTouched = sceneView.hitTest(local, options: nil)
            
            if let deepTouched = objTouched.first {
                let deep = deepTouched.node
                for i in 0...4 {
                    if deep.name == "Blackhole_\(i)" {
                        sceneView.removeDeep()
                        sceneView.addDeep()
                        ImpactFeedback.shared.generateHeavy()
                        break
                    }
                }
                
            }
            
        }
    }
    
    // MARK: - SETUP
    func config() {
        sceneView.showsStatistics = true
        configScene()
    }
    
    func configScene() {
        sceneView.config()
    }
}
