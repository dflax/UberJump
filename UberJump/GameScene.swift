//
//  GameScene.swift
//  UberJump
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

	// Layered Nodes
	let backgroundNode = SKNode()
	let midgroundNode = SKNode()
	let foregroundNode = SKNode()
	let hudNode = SKNode()

	// Player
	let player = SKNode()

	// To Accommodate iPhone 6
	let scaleFactor: CGFloat = 0.0

	// Tap To Start node
	let tapToStartNode = SKSpriteNode(imageNamed: "TapToStart")

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init(size: CGSize) {
		super.init(size: size)
		backgroundColor = SKColor.whiteColor()

		// Add some gravity
		physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)

		scaleFactor = self.size.width / 320.0

		// Create the game nodes
		// Background
		backgroundNode = createBackgroundNode()
		addChild(backgroundNode)

		// Foreground
		foregroundNode = SKNode()
		addChild(foregroundNode)

		// Add the player
		player = createPlayer()
		foregroundNode.addChild(player)

		// HUD
		hudNode = SKNode()
		addChild(hudNode)

		// Tap to Start
		tapToStartNode.position = CGPoint(x: self.size.width / 2, y: 180.0)
		hudNode.addChild(tapToStartNode)

	}

	func createBackgroundNode() -> SKNode {
		// 1
		// Create the node
		let backgroundNode = SKNode()
		let ySpacing = 64.0 * scaleFactor

		// 2
		// Go through images until the entire background is built
		for index in 0...19 {

			// 3
			let node = SKSpriteNode(imageNamed:String(format: "Background%02d", index + 1))

			// 4
			node.setScale(scaleFactor)
			node.anchorPoint = CGPoint(x: 0.5, y: 0.0)
			node.position = CGPoint(x: self.size.width / 2, y: ySpacing * CGFloat(index))

			//5
			backgroundNode.addChild(node)
		}

		// 6
		// Return the completed background node
		return backgroundNode
	}

	// Add the UberJumper
	func createPlayer() -> SKNode {
		let playerNode = SKNode()
		playerNode.position = CGPoint(x: self.size.width / 2, y: 80.0)

		let sprite = SKSpriteNode(imageNamed: "Player")
		playerNode.addChild(sprite)

		// 1
		playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)

		// 2
		playerNode.physicsBody?.dynamic = false

		// 3
		playerNode.physicsBody?.allowsRotation = false

		// 4
		playerNode.physicsBody?.restitution = 1.0
		playerNode.physicsBody?.friction = 0.0
		playerNode.physicsBody?.angularDamping = 0.0
		playerNode.physicsBody?.linearDamping = 0.0

		return playerNode
	}

	// Handle touch events
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

		// 1
		// If we're already playing, ignore touches
		if player.physicsBody!.dynamic {
			return
		}

		// 2
		// Remove the Tap to Start node
		tapToStartNode.removeFromParent()

		// 3
		// Start the player by putting them into the physics simulation
		player.physicsBody?.dynamic = true

		// 4
		player.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
	}


}

