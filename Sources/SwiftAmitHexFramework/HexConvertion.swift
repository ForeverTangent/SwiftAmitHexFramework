//
//  HexConvertion.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/22/20.
//

import Foundation
import simd


/**
Based on [Hex Layout](https://www.redblobgames.com/grids/hexagons/implementation.html#layout)
SIMD Version
*/
public struct HexConvertion<T: FloatingPoint> {

	// MARK: - Properties

	var hexLayout: HexLayout<T>

	// MARK: - Inits

	init(hexLayout: HexLayout<T>) {
		self.hexLayout = hexLayout
	}

	// MARK: - Methods

	/**
	Equivalent to [hexToPixel](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-to-pixel).

	Renamed to take advantage of Swift's self-documenting.
	*/
	func getPixelFromHex(_ hex: Hex) -> HexWorldPoint<T>? {

		let coverting = hexLayout.orientation

		let x_forward_q = coverting.forward_X * T(hex.q)
		let x_forward_r = coverting.forward_Y * T(hex.r)
		let y_forward_q = coverting.forward_Z * T(hex.q)
		let y_forward_r = coverting.forward_W * T(hex.r)

		let x = (x_forward_q + x_forward_r) * hexLayout.size.x
		let y = (y_forward_q + y_forward_r) * hexLayout.size.y

		return HexWorldPoint(x: x + hexLayout.origin.x, y: y + hexLayout.origin.y)
	}

	/**
	Equivalent to [pixelToHex](https://www.redblobgames.com/grids/hexagons/implementation.html#pixel-to-hex).

	Renamed to take advantage of Swift's self-documenting.
	*/
	func getHexFromWorldPoint(_ worldPoint: HexWorldPoint<T>) -> HexFractional<T>? {

		let theHexOrientation: HexOrientation = hexLayout.orientation

		guard
			let theWorldPoint = HexWorldPoint<T>(
				x: (worldPoint.x - hexLayout.origin.x) / hexLayout.size.x,
				y:  (worldPoint.y - hexLayout.origin.y) / hexLayout.size.y) else {
					return nil
		}

		let q: Double = (theHexOrientation.inverse_X * theWorldPoint.x + theHexOrientation.inverse_Y * theWorldPoint.y) as! Double
		let r: Double = (theHexOrientation.inverse_Z * theWorldPoint.x + theHexOrientation.inverse_W * theWorldPoint.y) as! Double

		return HexFractional(q: q, r: r, s: -q - r);
	}


	/**
	[Rounding fractional hex to hex](https://www.redblobgames.com/grids/hexagons/implementation.html#rounding)
	- Parameter fractionalHex: FractionalHex<T>
	- Returns: a Hex
	*/
	func getHexRoundedFromFractionalHex(_ fractionalHex: HexFractional<T>) -> Hex {

		var q = round(fractionalHex.q as! Double)
		var r = round(fractionalHex.r as! Double)
		var s = round(fractionalHex.s as! Double)

		let q_diff = abs(q - (fractionalHex.q as! Double))
		let r_diff = abs(r - (fractionalHex.r as! Double))
		let s_diff = abs(s - (fractionalHex.s as! Double))

		if q_diff > r_diff && q_diff > s_diff {
			q = -r - s
		} else if r_diff > s_diff {
			r = -r - s
		} else {
			s = -q - r
		}

		return Hex(q: q, r: r, s: s)

	}


	/**
	Helper for linear interpolation between two Hexs

	Performs linear interpolation
	Refer to [Line Drawing](https://www.redblobgames.com/grids/hexagons/implementation.html#line-drawing)

	- Parameter a: Double
	- Parameter b: Double
	- Parameter amount: Double, ratio of the lerp amount
	- Returns: Double
	*/
	private func getLerpFrom(a: Double, toB b: Double, by amount: Double) -> Double {
		return a * (1 - amount) + b + amount
	}


	/**
	Get the lerp between two hexes.

	Refer to [hex_lerp](https://www.redblobgames.com/grids/hexagons/implementation.html#line-drawing)

	- Parameter hexA: Hex
	- Parameter hexB: Hex
	- Parameter amount: Double
	- Returns: HexFractional
	*/
	private func getLerpForHexA(_ hexA: Hex, toHexB hexB: Hex, by amount: Double) -> HexFractional<T> {
		return HexFractional(q: getLerpFrom(a: Double(hexA.q),
											toB: Double(hexB.q),
											by: amount),
							 r: getLerpFrom(a: Double(hexA.r),
											toB: Double(hexB.r),
											by: amount),
							 s: getLerpFrom(a: Double(hexA.s),
											toB: Double(hexB.s),
											by: amount))
	}



	/**
	Get the lerp between two hexes.

	Refer to [hex_lerp](https://www.redblobgames.com/grids/hexagons/implementation.html#line-drawing)

	- Parameter hexA: Hex
	- Parameter hexB: Hex
	- Parameter amount: Double
	- Returns: HexFractional
	*/
	private func getLerpForHexFractionalA(_ hexA: HexFractional<T>,
										  toHexFractionalB hexB: HexFractional<T>,
										  by amount: Double) -> HexFractional<T> {
		return HexFractional(q: getLerpFrom(a: hexA.q as! Double,
											toB: hexB.q as! Double,
											by: amount),
							 r: getLerpFrom(a: hexA.r as! Double,
											toB: hexB.r as! Double,
											by: amount),
							 s: getLerpFrom(a: hexA.s as! Double,
											toB: hexB.s as! Double,
											by: amount))
	}



	/**
	Get the hexs in line between two given hexes.

	Refer to [Line Drawing](https://www.redblobgames.com/grids/hexagons/implementation.html#line-drawing)
	(Using Nudging Version)

	- Parameter hexA: Hex
	- Parameter hexB: Hex
	- Returns: [Hex]
	*/
	func hexLineDrawBetweenHexA(_ hexA: Hex, hexB: Hex) -> [Hex] {
		let hexDistance = Hex.distance(a: hexA, b: hexB)

		// Commented out, if needed
		let hexA_nudged = HexFractional<T>(q: Double(hexA.q) + 1e-6,
										   r: Double(hexA.r) + 1e-6,
										   s: Double(hexA.s) + 1e-6)
		let hexB_nudged = HexFractional<T>(q: Double(hexB.q) + 1e-6,
										   r: Double(hexB.r) + 1e-6,
										   s: Double(hexB.s) + 1e-6)

		var results = [Hex]()
		let step: Double = 1.0 / Double(max(hexDistance, 1))

		for index in 0..<hexDistance {
			let lerpedHex = getLerpForHexFractionalA(hexA_nudged,
													 toHexFractionalB: hexB_nudged,
													 by: step * Double(index))
			let roundedHex = getHexRoundedFromFractionalHex(lerpedHex)
			results.append(roundedHex)
		}

		return results
	}

}
