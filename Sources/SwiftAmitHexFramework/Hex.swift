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
struct Hex: Codable { // Cube storage, cube constructor

	// MARK: - Properties

	private let position: simd_int3

	public var q: Int { get { return Int(position.x) } }
	public var r: Int { get { return Int(position.y) } }
	public var s: Int { get { return Int(position.z) } }

	// MARK: - Init

	init(q: Int, r: Int, s: Int) {
		precondition(q + r + s == 0, "All concordinates must sum to 0")
		self.position = simd_int3(x: Int32(q), y: Int32(r), z: Int32(s))
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
	- Parameter hex: Hex
	- Returns: Int
	*/
	func length(hex: Hex) -> Int{
		return Int((abs(hex.q) + abs(hex.r) + abs(hex.s)) / 2);
	}

	/**
	The distance between two hexes is the length of the line between them.
	- Parameter a: Hex
	- Parameter b: Hex
	- Returns: Int
	*/
	func distance(a: Hex, b: Hex) -> Int {
		return length(hex: a - b);
	}

}


// MARK: Protocol CustomStringConvertible

extension Hex: CustomStringConvertible {
	var description: String {
		get {
			return "q: \(q), r: \(r), s: \(s)"
		}
	}
}

// MARK: Protocol Equatable

extension Hex: Equatable {
	static func == (lhs: Hex, rhs: Hex) -> Bool {
		return lhs.q == rhs.q && lhs.r == rhs.r && lhs.s == rhs.s
	}

	static func != (lhs: Hex, rhs: Hex) -> Bool {
		return lhs.q != rhs.q || lhs.r != rhs.r || lhs.s != rhs.s
	}
}


// MARK: Protocol Comparable

extension Hex: Comparable {
	static func < (lhs: Hex, rhs: Hex) -> Bool {
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
