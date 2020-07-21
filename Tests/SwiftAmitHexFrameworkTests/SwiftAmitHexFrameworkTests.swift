import XCTest
@testable import SwiftAmitHexFramework

final class SwiftAmitHexFrameworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftAmitHexFramework().text, "Hello, World!")
    }

	func testHexCompare() {

		let hexA = Hex(q: 0, r: 0, s: 0)
		let hexB = Hex(q: 0, r: 0, s: 0)
		print("\t Testing: \(hexA) == \(hexB)")
		XCTAssertTrue(hexA == hexB)
		XCTAssertFalse(hexA != hexB)


		let hexC = Hex(q: 1, r: 0, s: -1)
		let hexD = Hex(q: 0, r: 0, s: 0)
		print("\t Testing: \(hexC) != \(hexD)")
		XCTAssertTrue(hexC != hexD)
		XCTAssertFalse(hexC == hexD)


		let hex1 = Hex(q: 0, r: -1, s: 1)
		let hex2 = Hex(q: 1, r: -1, s: 0)
		print("\t Testing: \(hex1) < \(hex2)")
		XCTAssertTrue(hex1 < hex2)
		XCTAssertFalse(hex1 >= hex2)


		let hex3 = Hex(q: 0, r: -1, s: 1)
		let hex4 = Hex(q: 2, r: -1, s: -1)
		print("\t Testing: \(hex3) < \(hex4)")
		XCTAssertTrue(hex3 < hex4)
		XCTAssertFalse(hex3 >= hex4)


		let hex5 = Hex(q: 2, r: 1, s: -3)
		let hex6 = Hex(q: 2, r: 2, s: -4)
		print("\t Testing: \(hex5) < \(hex6)")
		XCTAssertTrue(hex5 < hex6)
		XCTAssertFalse(hex5 >= hex6)


		let hex7 = Hex(q: 2, r: 2, s: -4)
		let hex8 = Hex(q: 2, r: 1, s: -3)
		print("\t Testing: \(hex8) < \(hex7)")
		XCTAssertTrue(hex7 > hex8)
		XCTAssertFalse(hex7 <= hex8)

	}


    static var allTests = [
        ("testExample", testExample),
    ]
}
