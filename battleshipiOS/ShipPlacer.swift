import UIKit

struct Ship {
    let shipSize: Int
    let alignment: String
}

struct URLStringNotFound: Error {
    let message: String
}

class ShipPlacer {
    
    let webService: Webservice
    
    init(webService: Webservice) {
        self.webService = webService
    }
    
    func place(_ ship: Ship, at coord: String, callback: @escaping ([String]) -> Void) throws {
        let params: [String: Any] = ["shipSize": ship.shipSize, "align": ship.alignment, "coordinate": coord]
        let url = URL(string: localizedString("placingOfShips", table: "urls"))
        guard let placingShipUrl = url else {
            throw URLStringNotFound(message: "\(url?.absoluteString) not found in urls table")
        }
        webService.post(url: placingShipUrl, parameters: params) { res in
            if let coords = res.result.value as? [String] {
                callback(coords)
            }
        }
    }
}
