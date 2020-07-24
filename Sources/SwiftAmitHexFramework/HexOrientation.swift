//
//  SAMHOrientation.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/21/20.
//

import Foundation
import simd

/**
Based on [Hex Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
SIMD Version
*/
enum HexOrientationType<T: FloatingPoint>: Int, Codable {
	case flatTop
	case pointedTop

	var value: HexOrientation<T> {
		get {
			switch self {
				case .pointedTop: return HexOrientation(forward: simd_double4(x: sqrt(3.0),
																			  y: sqrt(3.0) / 2.0,
																			  z: 0.0,
																			  w: 3.0 / 2.0),
														up: simd_double4(x: sqrt(3.0) / 3.0,
																		 y: -1.0 / 3.0,
																		 z: 0.0,
																		 w: 2.0 / 3.0),
														startingAngle: 0.5)
				case .flatTop: return HexOrientation(forward: simd_double4(x: 3.0 / 2.0,
																		   y: 0.0,
																		   z: sqrt(3.0) / 2.0,
																		   w: sqrt(3.0)),
													 up: simd_double4(x: 2.0 / 3.0,
																	  y: 0.0,
																	  z: -1.0 / 3.0,
																	  w: sqrt(3.0) / 3.0),
													 startingAngle: 0.0)
			}
		}
	}
}

extension HexOrientationType: CustomStringConvertible {
	// MARK: CustomStringConvertible
	var description: String {
		get {
			switch self {
				case .flatTop: return "Flat Top"
				case .pointedTop: return "Pointed Top"
			}
		}
	}
}


/**
Refer to: [Amit's Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
*/
public struct HexOrientation<T: FloatingPoint> {

	// MARK: - Properties

	private let forward: simd_double4
	private let up: simd_double4
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

	var up_X: T {
		get {
			let theValue = self.up.x as! T
			return theValue
		}
	}

	var up_Y: T {
		get {
			let theValue = self.up.y as! T
			return theValue
		}
	}

	var up_Z: T {
		get {
			let theValue = self.up.z as! T
			return theValue
		}
	}

	var up_W: T {
		get {
			let theValue = self.up.w as! T
			return theValue
		}
	}

	// MARK: - Inits

	init(forward_0: Double, forward_1: Double, forward_2: Double, forward_3: Double,
		 up_0: Double, up_1: Double, up_2: Double, up_3: Double,
		 startingAngle: Double) {
		self.forward = simd_double4(forward_0, forward_1, forward_2, forward_3)
		self.up = simd_double4(up_0, up_1, up_2, up_3)
		self.startingAngle = startingAngle
	}

	init(forward: simd_double4, up: simd_double4, startingAngle: Double) {
		self.forward = forward
		self.up = up
		self.startingAngle = startingAngle
	}
}


/**
Refer to: [Amit's Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
*/
public struct HexLayout<T: FloatingPoint> {

	// MARK: - Properties

	let orientation: HexOrientation<T>
	let size: WorldPoint<T>
	let origin: WorldPoint<T>

	// MARK: - Inits

	init(orientation: HexOrientation<T>, size: WorldPoint<T>, origin: WorldPoint<T>) {
		self.orientation = orientation
		self.size = size
		self.origin = origin
	}

}

/**
World Coordinate in whatever units you are using.

Refer to: [Amit's Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
*/
public struct WorldPoint<T: FloatingPoint> {

	// MARK: - Properties

	private let data: simd_double2

	var x: T {
		get {
			let theValue = self.data.x as! T
			return theValue
		}
	}
	var y: T {
		get {
			let theValue = self.data.y as! T
			return theValue
		}
	}

	// MARK: - Inits

	init?<T: FloatingPoint>(x: T, y: T) {
		guard
			let theX = x as? Double,
			let theY = y as? Double else {
				return nil
		}

		self.data = simd_double2(x: theX, y: theY)
	}

}
