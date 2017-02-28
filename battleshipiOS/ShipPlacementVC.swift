import UIKit

class ShipPlacementVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var alignmentControl: UISegmentedControl?
    var placedShips = [String]()
    let cells = Cells().cells
    var ships = [2,2,3,4,5];
    
    var name: String = "ship placement view controller"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 35, height: 35)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cells will be intialise here with id and index number
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shipPlacementCell", for: indexPath) as? ShipPlacementCell
        cell?.configureCell(cellId: "\(indexPath.section)\(indexPath.item)")
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        var parameters: [String: Any] = [:]
        parameters["shipSize"] = ships.popLast()
        parameters["align"] = alignmentControl?.selectedSegmentIndex == 0 ? "horizontal" : "vertical"
        let coord: String = CoordinateMaper().mapToAlpha(numericCoord: "\(indexPath.section)\(indexPath.item + 1)")
        parameters["coordinate"] = coord
        let url = URL(string: localizedString("placingOfShips", table: "urls"))
        Webservice().post(url: url!, parameters: parameters, completion: { res in
            if let coords = res.result.value as? [String] {
                coords.forEach({ (coord) in
                    let numericCoord: String = CoordinateMaper().mapToNumeric(alphaCoord: coord)
                    let nums:[Int] = numericCoord.splitIntoInt()
                    let cell = collectionView.cellForItem(at: IndexPath(item: nums[1] - 1, section: nums[0]))
                    cell?.backgroundColor = UIColor.red
                })
                self.placedShips.append(contentsOf: coords)
                if self.ships.count == 0 {
                    let alertController = UIAlertController(title: "Ready", message: "waiting for enemy", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
}
