import UIKit
import SDWebImage

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
        imgViewContent.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgViewContent.sd_setImage(with: model.posterURL, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgViewContent.sd_cancelCurrentImageLoad()
        imgViewContent.image = nil
    }
}
