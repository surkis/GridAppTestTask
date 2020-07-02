import Foundation
import UIKit.UITableViewCell
import UIKit.UICollectionViewCell

protocol BaseViewCellProtocol: AnyObject {
  
}

protocol BaseViewModelCellType: BaseViewCellProtocol {
  func setup(viewModel: ModelViewProtocol)
}

class BaseViewTableViewCell: UITableViewCell, BaseViewModelCellType {
    
    func setup(viewModel: ModelViewProtocol) {
        
    }
}

class BaseViewCollectionCell: UICollectionViewCell, BaseViewModelCellType {
    
    func setup(viewModel: ModelViewProtocol) {
        
    }
}
