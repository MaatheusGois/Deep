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
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: - SETUP
    func config() {
        configScene()
    }
    
    func configScene() {
        sceneView.config()
        sceneView.debug()
    }
}
