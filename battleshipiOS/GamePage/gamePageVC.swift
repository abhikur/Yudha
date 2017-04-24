import UIKit
import CollectionViewLayouter

class gamePageVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var opponentGrid: UICollectionView?
    @IBOutlet weak var myGrid: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myGrid?.dataSource = self
        opponentGrid?.dataSource = self
        myGrid?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        opponentGrid?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        Layouter.layout(view: opponentGrid!, cellsInSection: 10)
        Layouter.layout(view: myGrid!, cellsInSection: 10)
        
        getMyGridCells()
    }
    
    func getMyGridCells() {
        let url = URL(string: localizedString("usedSpaces", table: "urls"))
        Webservice().get(url: url!) { (res) in
            if let coords = res.result.value as? [String] {
                self.fillMyGrid(coords)
                self.myGrid?.reloadData()
            }
        }
    }
    
    func fillMyGrid(_ coords: [String]) {
        coords.forEach { (coord) in
            let numericCoord: Coord = CoordinateMaper().mapToNumeric(alphaCoord: coord)
            let cell = self.myGrid?.cellForItem(at: IndexPath(item: numericCoord.column - 1, section: numericCoord.row))
            cell?.backgroundColor = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = "myGridCell"
        if(collectionView == opponentGrid) {
            identifier = "oppGridCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

}
