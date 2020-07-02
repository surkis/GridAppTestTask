import UIKit
import SDWebImage

protocol MainItemCellType: BaseViewModelCellType {
    
}

class MainItemCollectionViewCell: UICollectionViewCell, MainItemCellType {
    
    @IBOutlet weak var imgViewContent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func setup(viewModel: ModelViewProtocol) {
        guard let model = viewModel as? MovieItemModelView else {
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
