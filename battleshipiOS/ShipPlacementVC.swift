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
    
        let parameters: [String: Any] = getparamsForPlaceShipRequest(indexPath: indexPath)
        let url = URL(string: localizedString("placingOfShips", table: "urls"))
        
        Webservice().post(url: url!, parameters: parameters, completion: { res in
            if let coords = res.result.value as? [String] {
                let _ = self.ships.popLast()
                self.fillCoords(coords: coords)
                if self.ships.count == 0 {
                    self.sendReadyRequest()
                }
            }
        })
    }
    
    func getparamsForPlaceShipRequest(indexPath: IndexPath) -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["shipSize"] = ships.last
        parameters["align"] = alignmentControl?.selectedSegmentIndex == 0 ? "horizontal" : "vertical"
        let coord: String = CoordinateMaper().mapToAlpha(numericCoord: "\(indexPath.section)\(indexPath.item + 1)")
        parameters["coordinate"] = coord
        return parameters
    }
    
    func fillCoords(coords: [String]) {
        coords.forEach({ (coord) in
            let numericCoord: String = CoordinateMaper().mapToNumeric(alphaCoord: coord)
            let nums:[Int] = numericCoord.splitIntoInt()
            let cell = self.collectionView?.cellForItem(at: IndexPath(item: nums[1] - 1, section: nums[0]))
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
                    self.present(gamePageVC, animated: true, completion: nil)
                }
            }
        })
    }
}
