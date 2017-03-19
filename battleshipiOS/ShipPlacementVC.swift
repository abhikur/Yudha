import UIKit

class ShipPlacementVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var alignmentControl: UISegmentedControl?
    var placedShips = [String]()
    var ships = [2,3,3,4,5];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        layoutCells()
    }
    
    func layoutCells() {
        collectionView?.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let minSpaceBetweenItems: CGFloat = 1
            let minSpaceBetweenLines: CGFloat = 1
            layout.minimumLineSpacing = minSpaceBetweenLines
            layout.minimumInteritemSpacing = minSpaceBetweenItems
            let cellWidth: CGFloat = (self.view.bounds.width - 16 - (9 * minSpaceBetweenItems)) / 10
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
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
                if self.ships.count == 0 {
                    print("player is ready ")
                    Webservice().get(url: URL(string:localizedString("makeReady", table: "urls"))!, completion: { (res) in
                        if let resData = res.result.value as? [String: Any] {
                            print(resData)
                        }
                        else {
                            let alertController = Alert.makeWithoutAction(title: "Ready...", msg: "let the enemy ready")
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                }
            }
        })
    }
}
