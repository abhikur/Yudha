import XCTest
@testable import battleshipiOS

class CoordinateMaperSpec: XCTestCase {
    
    func testShouldSplitPassedString() {
        let h1 = "H1"
        let expectedResult = ["H", "1"]
        let splitedString = h1.split()
        XCTAssertEqual(splitedString, expectedResult)
    }
    
    func testShouldMapAlphaToRespectedNum() {
        XCTAssertEqual(CoordinateMaper().alphaToNum("A"), "0")
        XCTAssertEqual(CoordinateMaper().alphaToNum("F"), "5")
    }
    
    func testShouldMapNumToRespectedAlpha() {
        XCTAssertEqual(CoordinateMaper().numToAlpha("2"), "C")
        XCTAssertEqual(CoordinateMaper().numToAlpha("6"), "G")
    }
    
    func testShouldMapPassedAlphaCoordToNumericCoord() {
        let coord = "A1"
        let expectedCoord = "01"
        let mapedCoord: String = CoordinateMaper().mapToNumeric(alphaCoord: coord)
        XCTAssertEqual(mapedCoord, expectedCoord)
    }
    
    func testShouldMapPassedNumericCoordsToAlphaCoords() {
        let coord = "01"
        let expectedCoord = "A1"
        let mapedCoord: String = CoordinateMaper().mapToAlpha(numericCoord: coord)
        XCTAssertEqual(mapedCoord, expectedCoord)
    }
    
    func testShouldConvertStringToInt() {
        XCTAssertEqual("1".toInt(), 1)
    }
}
