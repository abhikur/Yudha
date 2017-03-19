public class Layouter {
    public class func layout(view: UICollectionView, cellsInSection: CGFloat) {
        view.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0)
        if let layout = view.collectionViewLayout as? UICollectionViewFlowLayout {
            let minSpaceBetweenItems: CGFloat = 1
            let minSpaceBetweenLines: CGFloat = 1
            layout.minimumLineSpacing = minSpaceBetweenLines
            layout.minimumInteritemSpacing = minSpaceBetweenItems
            let cellWidth: CGFloat = (view.bounds.width - ((cellsInSection - 1) * minSpaceBetweenItems)) / cellsInSection
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
    }
}
