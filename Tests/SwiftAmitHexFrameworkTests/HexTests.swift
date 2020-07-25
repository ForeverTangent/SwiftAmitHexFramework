//
//  HexTests.swift
//  SwiftAmitHexFramework
//
//  Created by Stanley Rosenbaum on 7/24/20.
//

import XCTest
@testable import SwiftAmitHexFramework

final class HexTests: XCTestCase {
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.

		print("\tHex Tests\n")

	}

	func testHexAddition() {
		print("\tHex Addition\n")

		let hex1 = Hex(q: 1, r: 1, s: -2)
		let hex2 = Hex(q: -2, r: 0, s: 2)

		let hex3 = hex1 + hex2

		XCTAssertTrue(hex3.q == -1)
		XCTAssertTrue(hex3.r == 1)
		XCTAssertTrue(hex3.s == 0)

	}

	func testHexSubstraction() {
		print("\tHex Substraction\n")

		let hex1 = Hex(q: 1, r: 1, s: -2)
		let hex2 = Hex(q: -2, r: 0, s: 2)

		let hex3 = hex1 - hex2

		XCTAssertTrue(hex3.q == 3)
		XCTAssertTrue(hex3.r == 1)
		XCTAssertTrue(hex3.s == -4)

	}

	func testHexMultiplication() {
		print("\tHex Multiplication\n")

		let hex1 = Hex(q: 1, r: 1, s: -2)
		let scalar = 2

		let hex3 = scalar * hex1

		XCTAssertTrue(hex3.q == 2)
		XCTAssertFalse(hex3.q != 2)
		XCTAssertTrue(hex3.r == 2)
		XCTAssertFalse(hex3.r != 2)
		XCTAssertTrue(hex3.s == -4)
		XCTAssertFalse(hex3.s != -4)

		let hex4 = hex1 * scalar

		XCTAssertTrue(hex4.q == 2)
		XCTAssertFalse(hex4.q != 2)
		XCTAssertTrue(hex4.r == 2)
		XCTAssertFalse(hex4.r != 2)
		XCTAssertTrue(hex4.s == -4)
		XCTAssertFalse(hex4.s != -4)

		let hex5 = hex1 * 0

		XCTAssertTrue(hex5.q == 0)
		XCTAssertFalse(hex5.q != 0)
		XCTAssertTrue(hex5.r == 0)
		XCTAssertFalse(hex5.r != 0)
		XCTAssertTrue(hex5.s == 0)
		XCTAssertFalse(hex5.s != 0)

	}


	func testHexLength() {
		print("\tHex Length\n")

		let hex1 = Hex(q: 1, r: 1, s: -2)
		let hex2 = Hex(q: -1, r: -1, s: 2)

		let hex3 = Hex(q: 2, r: 2, s: -4)
		let hex4 = Hex(q: -2, r: -2, s: 4)

		XCTAssertTrue(hex1.length() == 2)
		XCTAssertFalse(hex1.length() != 2)

		XCTAssertTrue(hex2.length() == 2)
		XCTAssertFalse(hex2.length() != 2)

		XCTAssertTrue(hex3.length() == 4)
		XCTAssertFalse(hex3.length() != 4)

		XCTAssertTrue(hex4.length() == 4)
		XCTAssertFalse(hex4.length() != 4)

	}

	func testHexDistance() {
		print("\tHex Distance\n")

		let hex1 = Hex(q: 1, r: 1, s: -2)
		let hex2 = Hex(q: -1, r: -1, s: 2)

		let hex3 = Hex(q: 2, r: 2, s: -4)
		let hex4 = Hex(q: -2, r: -2, s: 4)

		let hex1_2Distacnce = Hex.distance(a: hex1, b: hex2)
		let hex3_4Distacnce = Hex.distance(a: hex3, b: hex4)

		XCTAssertTrue(hex1_2Distacnce == 4)
		XCTAssertTrue(hex3_4Distacnce == 8)

	}

	func testHexNeighboy() {
		print("\tHex Neighbors\n")

		var hex1 = Hex(q: 3, r: 4, s: -7)

		let neighbor0 = hex1.neighbors[0]
		XCTAssertTrue(neighbor0.q == 4)
		XCTAssertTrue(neighbor0.r == 4)
		XCTAssertTrue(neighbor0.s == -8)

		let neighbor1 = hex1.neighbors[1]
		XCTAssertTrue(neighbor1.q == 4)
		XCTAssertTrue(neighbor1.r == 3)
		XCTAssertTrue(neighbor1.s == -7)

		let neighbor2 = hex1.neighbors[2]
		XCTAssertTrue(neighbor2.q == 3)
		XCTAssertTrue(neighbor2.r == 3)
		XCTAssertTrue(neighbor2.s == -6)

		let neighbor3 = hex1.neighbors[3]
		XCTAssertTrue(neighbor3.q == 2)
		XCTAssertTrue(neighbor3.r == 4)
		XCTAssertTrue(neighbor3.s == -6)

		let neighbor4 = hex1.neighbors[4]
		XCTAssertTrue(neighbor4.q == 2)
		XCTAssertTrue(neighbor4.r == 5)
		XCTAssertTrue(neighbor4.s == -7)

		let neighbor5 = hex1.neighbors[5]
		XCTAssertTrue(neighbor5.q == 3)
		XCTAssertTrue(neighbor5.r == 5)
		XCTAssertTrue(neighbor5.s == -8)

	}


	func testHexCompare() {
		print("\tHex Comparing\n")

		let hexA = Hex(q: 0, r: 0, s: 0)
		let hexB = Hex(q: 0, r: 0, s: 0)
		print("\t Testing: \(hexA) \t==\t \(hexB)")
		XCTAssertTrue(hexA == hexB)
		XCTAssertFalse(hexA != hexB)


		let hexC = Hex(q: 1, r: 0, s: -1)
		let hexD = Hex(q: 0, r: 0, s: 0)
		print("\t Testing: \(hexC) \t!=\t \(hexD)")
		XCTAssertTrue(hexC != hexD)
		XCTAssertFalse(hexC == hexD)


		let hex1 = Hex(q: 0, r: -1, s: 1)
		let hex2 = Hex(q: 1, r: -1, s: 0)
		print("\t Testing: \(hex1) \t<\t \(hex2)")
		XCTAssertTrue(hex1 < hex2)
		XCTAssertFalse(hex1 >= hex2)


		let hex3 = Hex(q: 0, r: -1, s: 1)
		let hex4 = Hex(q: 2, r: -1, s: -1)
		print("\t Testing: \(hex3) \t<\t \(hex4)")
		XCTAssertTrue(hex3 < hex4)
		XCTAssertFalse(hex3 >= hex4)


		let hex5 = Hex(q: 2, r: 1, s: -3)
		let hex6 = Hex(q: 2, r: 2, s: -4)
		print("\t Testing: \(hex5) \t<\t \(hex6)")
		XCTAssertTrue(hex5 < hex6)
		XCTAssertFalse(hex5 >= hex6)


		let hex7 = Hex(q: 2, r: 2, s: -4)
		let hex8 = Hex(q: 2, r: 1, s: -3)
		print("\t Testing: \(hex8) \t<\t \(hex7)")
		XCTAssertTrue(hex7 > hex8)
		XCTAssertFalse(hex7 <= hex8)

	}

	static var allTests = [
		("testExample", testExample),
		("testHexAddition", testHexAddition),
		("testHexSubstraction", testHexSubstraction),
		("testHexMultiplication", testHexMultiplication),
		("testHexCompare", testHexCompare),
		("testHexLength", testHexLength),
		("testHexDistance", testHexDistance),
	]

}

