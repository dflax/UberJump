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

	var starType: StarType!

	override func collisionWithPlayer(player: SKNode) -> Bool {

		// Boost the player up
		player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400.0)

		// Remove this Star
		self.removeFromParent()

		// The HUD needs updating to show the new stars and score
		return true
	}
}



