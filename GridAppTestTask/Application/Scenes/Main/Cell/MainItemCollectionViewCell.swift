import UIKit

protocol MainItemCollectionCellType: BaseViewModelCellType {
    
}

class MainItemCollectionViewCell: UICollectionViewCell, MainItemCollectionCellType {
    
    @IBOutlet weak var imgViewContent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setup(viewModel: ModelViewProtocol) {
        guard let model = viewModel as? MoviItemModelView else {
            return
        }
    }
}
