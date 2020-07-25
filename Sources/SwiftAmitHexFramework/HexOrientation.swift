//
//  SAMHOrientation.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/21/20.
//

import Foundation
import simd

/**
Refer to: [Amit's Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
*/
public struct HexOrientation<T: FloatingPoint> {

	// MARK: - Properties

	private let forward: simd_double4
	private let inverse: simd_double4
	let startingAngle: Double // in multiples of 60°

	var forward_X: T {
		get {
			let theValue = self.forward.x as! T
			return theValue
		}
	}

	var forward_Y: T {
		get {
			let theValue = self.forward.y as! T
			return theValue
		}
	}

	var forward_Z: T {
		get {
			let theValue = self.forward.z as! T
			return theValue
		}
	}

	var forward_W: T {
		get {
			let theValue = self.forward.w as! T
			return theValue
		}
	}

	var inverse_X: T {
		get {
			let theValue = self.inverse.x as! T
			return theValue
		}
	}

	var inverse_Y: T {
		get {
			let theValue = self.inverse.y as! T
			return theValue
		}
	}

	var inverse_Z: T {
		get {
			let theValue = self.inverse.z as! T
			return theValue
		}
	}

	var inverse_W: T {
		get {
			let theValue = self.inverse.w as! T
			return theValue
		}
	}

	// MARK: - Inits

	init(forward_0: Double, forward_1: Double, forward_2: Double, forward_3: Double,
		 inverse_0: Double, inverse_1: Double, inverse_2: Double, inverse_3: Double,
		 startingAngle: Double) {
		self.forward = simd_double4(forward_0, forward_1, forward_2, forward_3)
		self.inverse = simd_double4(inverse_0, inverse_1, inverse_2, inverse_3)
		self.startingAngle = startingAngle
	}

	init(forward: simd_double4, inverse: simd_double4, startingAngle: Double) {
		self.forward = forward
		self.inverse = inverse
		self.startingAngle = startingAngle
	}
}





