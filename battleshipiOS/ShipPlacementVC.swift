import UIKit
import CollectionViewLayouter

class ShipPlacementVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var alignmentControl: UISegmentedControl?
    var placedShips = [String]()
    var ships = [2,3,3,4,5];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        Layouter.layout(view: collectionView!, cellsInSection: 10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillLayoutSubviews() {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shipPlacementCell", for: indexPath) as? ShipPlacementCell
        cell?.configureCell(cellId: "\(indexPath.section)\(indexPath.item)")
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let alignment = alignmentControl?.selectedSegmentIndex == 0 ? "horizontal" : "vertical"
        let ship = Ship(shipSize: ships.last!, alignment: alignment)
        let coord: String = CoordinateMaper().mapToAlpha(numericCoord: Coord(row: indexPath.section, column: indexPath.item + 1))
        
        let shipPlacer = ShipPlacer(webService: Webservice())
        do {
            try shipPlacer.place(ship, at: coord) { coords in
                let _ = self.ships.popLast()
                self.fillCoords(coords: coords)
                if self.ships.count == 0 {
                    self.sendReadyRequest()
                }
            }
        } catch let error {
            print("\(error): Couldn't place the ship at this place")
        }
    }
    
    func fillCoords(coords: [String]) {
        coords.forEach({ (coord) in
            let numericCoord: Coord = CoordinateMaper().mapToNumeric(alphaCoord: coord)
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: numericCoord.column - 1, section: numericCoord.row))
            cell?.backgroundColor = UIColor.red
        })
    }
    
    func sendReadyRequest() {
        Webservice().get(url: URL(string:localizedString("makeReady", table: "urls"))!, completion: { (res) in
            if let resData = res.result.value as? [String: Bool] {
                if(resData["isReady"] == false) {
                    let alertController = Alert.makeWithoutAction(title: "Ready...", msg: "let the enemy ready")
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    let gamePage = UIStoryboard.init(name: "GamePage", bundle: nil)
                    let gamePageVC = gamePage.instantiateViewController(withIdentifier: "gamePage")
                    self.navigationController?.pushViewController(gamePageVC, animated: true)
                }
            }
        })
    }
}
