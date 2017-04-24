import XCTest
import Alamofire
@testable import battleshipiOS

class WebserviceMock: Webservice {
    
    override func post(url: URL, parameters: Parameters, completion: @escaping (DataResponse<Any>) -> Void) {
        let value: Any = ["A2", "A3"]
        let url = URL(string: "someurl")
        
        let res = DataResponse(request: URLRequest(url:url!), response: HTTPURLResponse(), data: Data(), result: Result.success(value))
        completion(res)
    }
}

class ShipPlacerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    func testShouldGetNextCoordsOfThePassedCoord() {
        let webService = WebserviceMock()
        let shipPlacer = ShipPlacer(webService: webService)
        let ship = Ship(shipSize: 2, alignment: "Vertical")
        var nextCoords = [String]()
        
        let callback = { (coords: [String]) in
            nextCoords.append(contentsOf: coords)
        }
        do {
            try shipPlacer.place(ship, at: "A1", callback: callback)
            XCTAssertTrue(nextCoords.contains("A2"))
            XCTAssertTrue(nextCoords.contains("A3"))
            XCTAssertFalse(nextCoords.contains("A4"))
        } catch let error {
            XCTAssertTrue(false, "\(error): couldn't place ship at given coord")
        }
    }
}
