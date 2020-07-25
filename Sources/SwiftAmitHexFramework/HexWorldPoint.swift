//
//  WorldPoint.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/24/20.
//

import Foundation
import simd

/**
HexWorldPoint are the representive of whatever (graphic?) units you are using.  For example if you drawing to UIKit
You would use CGPoint.  HexWorldPoint is the equivalent to the CGPoint.

I wanted to make SAHF as generic as possible, so that is why I subbed HexWorldPoint insteady of using CGPoint directly.
Ideality I think it would be nice to give the classes that make use of the "Point" classed to make use of whatever under
lying structure to use.   But I couldn't figure out how to do that cleanly.

Refer to: [Amit's Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
*/
public struct HexWorldPoint<T: FloatingPoint> {

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
