//
//  GameObjectNode.swift
//  UberJump
//
//  Created by Daniel Flax on 4/6/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import SpriteKit

//
struct CollisionCategoryBitmask {
	static let Player: UInt32 = 0x00
	static let Star: UInt32 = 0x01
	static let Platform: UInt32 = 0x02
}

enum StarType: Int {
	case Normal = 0
	case Special
}

enum PlatformType: Int {
	case Normal = 0
	case Break
}

class GameObjectNode: SKNode {

	func collisionWithPlayer(player: SKNode) -> Bool {
		return false
	}

	func checkNodeRemoval(playerY: CGFloat) {
		if playerY > self.position.y + 300.0 {
			self.removeFromParent()
		}
	}
}


// Star node for game objects
class StarNode: GameObjectNode {

	// Set the sound for collisions
	let starSound = SKAction.playSoundFileNamed("StarPing.wav", waitForCompletion: false)

	// What kind of star
	var starType: StarType!

	override func collisionWithPlayer(player: SKNode) -> Bool {

		// Boost the player up
		player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)

		// Remove this Star
		// Play sound
		runAction(starSound, completion: {
			// Remove this Star
			self.removeFromParent()
		})

		// Award score
		GameState.sharedInstance.score += (starType == .Normal ? 20 : 100)

		// Award stars
		GameState.sharedInstance.stars += (starType == .Normal ? 1 : 5)

		// The HUD needs updating to show the new stars and score
		return true
	}
}


// PlatformNode
class PlatformNode: GameObjectNode {

	var platformType: PlatformType!

	override func collisionWithPlayer(player: SKNode) -> Bool {
		// 1
		// Only bounce the player if he's falling
		if player.physicsBody?.velocity.dy < 0 {
			// 2
			player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250.0)

			// 3
			// Remove if it is a Break type platform
			if platformType == .Break {
				self.removeFromParent()
			}
		}

		// 4
		// No stars for platforms
		return false
	}
}






