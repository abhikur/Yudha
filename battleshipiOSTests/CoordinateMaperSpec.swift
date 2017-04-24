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
        let expectedCoord = Coord(row: 0, column: 1)
        let mapedCoord: Coord = CoordinateMaper().mapToNumeric(alphaCoord: coord)
        
        XCTAssertEqual(mapedCoord.column, expectedCoord.column)
        XCTAssertEqual(mapedCoord.row, expectedCoord.row)
    }
    
    func testShouldMapPassedNumericCoordsToAlphaCoords() {
        let coord = Coord(row: 0, column: 10)
        let expectedCoord = "A10"
        let mapedCoord: String = CoordinateMaper().mapToAlpha(numericCoord: coord)
        XCTAssertEqual(mapedCoord, expectedCoord)
    }
    
    func testShouldConvertStringToInt() {
        XCTAssertEqual("1".splitIntoInt(), [0,1])
    }
}
