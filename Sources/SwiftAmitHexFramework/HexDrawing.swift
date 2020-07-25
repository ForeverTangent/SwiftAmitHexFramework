//
//  HexDrawing.swift
//  ComplexModule
//
//  Created by Stanley Rosenbaum on 7/23/20.
//

import Foundation

/**
Refer to [Amit's Drawing](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-geometry)
*/
public class HexDrawing<T: FloatingPoint>  {

	// MARK: - Properties

	var hexConvertor: HexConvertion<T>
	var hexLayout: HexLayout<T> {
		get {
			return hexConvertor.hexLayout
		}
	}

	// MARK: - Init

	init(hexConvertor: HexConvertion<T>) {
		self.hexConvertor = hexConvertor
	}

	// MARK: - Methods

	private func getOffsetForHexagonCorner(_ corner: Int) -> HexWorldPoint<T>? {
		let size: HexWorldPoint = hexLayout.size
		let angle = 2.0 * Double.pi * (hexLayout.orientation.startingAngle + Double(corner)) / 6.0
		return HexWorldPoint(x: size.x as! Double * cos(angle), y: size.y as! Double * sin(angle))
	}


	func getWorldPointsOfCornersForHex(_ hex: Hex) -> [HexWorldPoint<T>] {
		var hexagonCorners = [HexWorldPoint<T>]()
		let hexagonCenter = hexConvertor.getPixelFromHex(hex)

		for index in 0..<6 {
			let offset = getOffsetForHexagonCorner(index)
			if
				let theHexagonCenter = hexagonCenter,
				let theOffset = offset,
				let theWorldPoint = HexWorldPoint<T>(x: theHexagonCenter.x + theOffset.x,
												  y: theHexagonCenter.y + theOffset.y) {
				hexagonCorners.append(theWorldPoint)
			}
		}

		return hexagonCorners

	}

}
