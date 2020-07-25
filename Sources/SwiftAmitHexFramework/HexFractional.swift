//
//  HexFractional.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/23/20.
//

import Foundation
import simd

/**
To find positions inside a Hex

[Fractional Hex](https://www.redblobgames.com/grids/hexagons/implementation.html#fractionalhex)
*/
public struct HexFractional<T: FloatingPoint> {

	// MARK: - Properties

	private let data: simd_double3

	var q: T {
		get {
			let theValue = self.data.x as! T
			return theValue
		}
	}
	var r: T {
		get {
			let theValue = self.data.y as! T
			return theValue
		}
	}
	var s: T {
		get {
			let theValue = self.data.z as! T
			return theValue
		}
	}

	// MARK: - Init

	init(q: Double, r: Double, s: Double) {
		self.data = simd_double3(x: q, y: r, z: s)
	}

}
