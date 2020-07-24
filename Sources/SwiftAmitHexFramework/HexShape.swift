//
//  HexShape.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/23/20.
//

import Foundation

/**
[Hex Maps/Shapes](https://www.redblobgames.com/grids/hexagons/implementation.html#map)
*/
class HexShape {

	// MARK: - Properties

	var shapeSet: Set<Hex> = Set<Hex>()

}


/**
A Hexagon of Hexagons
*/
class HexHexagon: HexShape {

	// MARK: - Properties

	var radius: Int

	init(radius: Int) {
		self.radius = radius
		super.init()
	}

	private func buildHexagonSet() {
		let radius_1_Min = -radius
		let radius_1_Max = radius

		for current_q in radius_1_Min...radius_1_Max {
			let radius_2_Min = max(-radius, -radius_1_Max - radius)
			let radius_2_Max = min(-radius, -radius_1_Max + radius)

			for current_r in radius_2_Min...radius_2_Max {
				shapeSet.insert(Hex(q: current_q,
									r: current_r))
			}
		}

	}

}
