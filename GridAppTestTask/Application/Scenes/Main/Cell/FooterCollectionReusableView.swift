import UIKit

protocol FooterCollectionViewDelegate: AnyObject {
    func didSelect(_ view: FooterCollectionReusableView)
}

class FooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var btnMore: UIButton!
    
    weak var delegate: FooterCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func clickedBtnMore(_ sender: Any) {
        delegate?.didSelect(self)
    }
}
