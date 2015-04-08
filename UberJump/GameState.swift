//
//  GameState.swift
//  UberJump
//
//  Created by Daniel Flax on 4/7/15.
//  Copyright (c) 2015 Daniel Flax. All rights reserved.
//

import UIKit

class GameState {

	var score: Int
	var highScore: Int
	var stars: Int

	init() {
		// Init
		score = 0
		highScore = 0
		stars = 0

		// Load game state
		let defaults = NSUserDefaults.standardUserDefaults()

		highScore = defaults.integerForKey("highScore")
		stars = defaults.integerForKey("stars")
	}

	class var sharedInstance: GameState {
		struct Singleton {
			static let instance = GameState()
		}

		return Singleton.instance
	}

	func saveState() {
		// Update highScore if the current score is greater
		highScore = max(score, highScore)

		// Store in user defaults
		let defaults = NSUserDefaults.standardUserDefaults()
		defaults.setInteger(highScore, forKey: "highScore")
		defaults.setInteger(stars, forKey: "stars")
		NSUserDefaults.standardUserDefaults().synchronize()
	}

}