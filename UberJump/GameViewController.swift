//
//  GameViewController.swift
//  UberJump
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
}

class GameViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let skView = self.view as SKView

		skView.showsFPS = true
		skView.showsNodeCount = true

		let scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFit

		skView.presentScene(scene)
	}

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
