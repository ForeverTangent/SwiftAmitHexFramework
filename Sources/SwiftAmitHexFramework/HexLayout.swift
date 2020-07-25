//
//  HexLayout.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/24/20.
//

import Foundation
import CoreGraphics
import simd

/**
Based on [Hex Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
SIMD Version
*/
enum HexLayoutType<T: FloatingPoint>: Int, Codable {
	case flatTop
	case pointedTop

	var value: HexOrientation<T> {
		get {
			switch self {
				case .pointedTop:
					return HexOrientation(forward: simd_double4(x: sqrt(3.0),
																y: sqrt(3.0) / 2.0,
																z: 0.0,
																w: 3.0 / 2.0),
										  inverse: simd_double4(x: sqrt(3.0) / 3.0,
																y: -1.0 / 3.0,
																z: 0.0,
																w: 2.0 / 3.0),
										  startingAngle: 0.5)
				case .flatTop:
					return HexOrientation(forward: simd_double4(x: 3.0 / 2.0,
																y: 0.0,
																z: sqrt(3.0) / 2.0,
																w: sqrt(3.0)),
										  inverse: simd_double4(x: 2.0 / 3.0,
																y: 0.0,
																z: -1.0 / 3.0,
																w: sqrt(3.0) / 3.0),
										  startingAngle: 0.0)
			}
		}
	}
}

extension HexLayoutType: CustomStringConvertible {
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
public struct HexLayout<T: FloatingPoint> {

	// MARK: - Properties

	let orientation: HexOrientation<T>
	let size: HexWorldPoint<T>

	// This is the origin of where the Zero Hex should be in whatever domain.
	let origin: HexWorldPoint<T>

	// MARK: - Inits

	init(layout: HexLayoutType<T>, size: HexWorldPoint<T>, origin: HexWorldPoint<T>) {
		self.orientation = layout.value
		self.size = size
		self.origin = origin
	}

}
