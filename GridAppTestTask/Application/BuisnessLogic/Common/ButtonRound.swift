import UIKit

@IBDesignable class ButtonRound: UIButton {
    
    @IBInspectable var roundRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = roundRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}
