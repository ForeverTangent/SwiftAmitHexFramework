//
//  SAHHex.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/21/20.
//

import Foundation
import simd

/**
Based on [Hex Struct](https://www.redblobgames.com/grids/hexagons/implementation.html#hex)
SIMD Version
*/
public struct Hex: Codable { // Cube storage, cube constructor

	// MARK: - Properties

	private let position: simd_int3

	public var q: Int { get { return Int(position.x) } }
	public var r: Int { get { return Int(position.y) } }
	public var s: Int { get { return Int(position.z) } }

	public lazy var neighbors: [Hex] = {
		var neighborhood = [Hex]()
		for index in 0..<6 {
			let neighborHex = getHexNeighborInDirection(index)
			neighborhood.append(neighborHex)
		}
		return neighborhood
	}()

	/**
	Directions start with index 0 on tradisional cartesian plane along the x+ axis
	They increase going around the origin counter-clockwise in 60 degree increments.
	*/
	static public let directions: [Hex] = [
		Hex(q: 1, r: 0, s: -1),
		Hex(q: 1, r: -1, s: 0),
		Hex(q: 0, r: -1, s: 1),
		Hex(q: -1, r: 0, s: 1),
		Hex(q: -1, r: 1, s: 0),
		Hex(q: 0, r: 1, s: -1)
	]

	// MARK: - Init

	init(q: Int, r: Int, s: Int) {
		precondition(q + r + s == 0, "All concordinates must sum to 0")
		self.position = simd_int3(x: Int32(q), y: Int32(r), z: Int32(s))
	}

	init(q: Double, r: Double, s: Double) {
		precondition(q + r + s == 0, "All concordinates must sum to 0")
		self.position = simd_int3(x: Int32(q), y: Int32(r), z: Int32(s))
	}

	init(q: Int, r: Int) {
		self.init(q: q, r: r, s: q - r)
	}

	init(q: Double, r: Double) {
		self.init(q: q, r: r, s: q - r)
	}

	// MARK: - Operator Overrides

	static func +(lhs: Hex, rhs: Hex) -> Hex {
		let q = lhs.q + rhs.q
		let r = lhs.r + rhs.r
		let s = lhs.s + rhs.s

		return Hex(q: q, r: r, s: s)
	}

	static func -(lhs: Hex, rhs: Hex) -> Hex {
		let q = lhs.q - rhs.q
		let r = lhs.r - rhs.r
		let s = lhs.s - rhs.s

		return Hex(q: q, r: r, s: s)
	}

	static func *(lhs: Hex, rhs: Int) -> Hex {
		let q = lhs.q * rhs
		let r = lhs.r * rhs
		let s = lhs.s * rhs
		return Hex(q: q, r: r, s: s)
	}

	static func *(lhs: Int, rhs: Hex) -> Hex {
		return rhs * lhs
	}


	// MARK: - Methods


	/**
	Same as vector length

	See [Amit's Distance](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-distance)

	- Parameter hex: Hex
	- Returns: Int
	*/
	func length() -> Int {
		let sum  = abs(self.q) + abs(self.r) + abs(self.s)
		return sum / 2
	}


//	/**
//	Same as vector length
//
//	See [Amit's Distance](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-distance)
//
//	- Parameter hex: Hex
//	- Returns: Int
//	*/
//	static func length(hex: Hex) -> Int {
//		return Int((abs(hex.q) + abs(hex.r) + abs(hex.s)) / 2);
//	}

	/**
	The distance between two hexes is the length of the line between them.

	See [Amit's Distance](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-distance)

	- Parameter a: Hex
	- Parameter b: Hex
	- Returns: Int
	*/
	static func distance(a: Hex, b: Hex) -> Int {
		let hexDiff = a - b
		return hexDiff.length()
	}


	/**
	Gets the hex in the direction of given index.
	- Parameter index: Int, index of the direction
	- Returns: Hex
	*/
	func getHexInTheDirectionOfIndex(_ index: Int) -> Hex {
		return Hex.directions[index]
	}

	/**
	[Amit's Neighbors](https://www.redblobgames.com/grids/hexagons/implementation.html#hex-neighbors)
	- Parameter direction: Int, direction index
	- Returns: Hex
	*/
	func getHexNeighborInDirection(_ direction: Int) -> Hex {
		return self + getHexInTheDirectionOfIndex(direction)
	}


}


extension Hex: CustomStringConvertible {
	// MARK: Protocol CustomStringConvertible
	public var description: String {
		get {
			return "q: \(q), r: \(r), s: \(s)"
		}
	}
}


extension Hex: Equatable {
	// MARK: Protocol Equatable
	public static func == (lhs: Hex, rhs: Hex) -> Bool {
		return lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
	}

	public static func != (lhs: Hex, rhs: Hex) -> Bool {
		return lhs.q != rhs.q || lhs.r != rhs.r || lhs.s != rhs.s
	}
}


extension Hex: Comparable {
	// MARK: Protocol Comparable
	public static func < (lhs: Hex, rhs: Hex) -> Bool {
		if abs(lhs.q) < abs(rhs.q) {
			return true
		} else if abs(lhs.r) < abs(rhs.r) {
			return true
		} else if abs(lhs.s) < abs(rhs.s) {
			return true
		}
		return false
	}
}


extension Hex: Hashable {
	// MARK: Protocol Hashable
}


