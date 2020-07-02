import UIKit
import NVActivityIndicatorView

protocol BaseView: AnyObject {
    func displayError(messsage: String)
    func displayLoading(isShow: Bool)
}

class BaseViewController: UIViewController, BaseView, NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayError(messsage: String) {
        let alertViewController = UIAlertController(title: R.string.localizable.alert_error_title(),
                                                    message: messsage,
                                                    preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(
            title: R.string.localizable.alert_button_ok(),
            style: .default,
            handler: nil)
        )
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func displayLoading(isShow: Bool) {
        if isShow {
            startAnimating(type: .ballClipRotatePulse, color: .white,
                           minimumDisplayTime: 3, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7285423801), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        } else {
            stopAnimating()
        }
    }

}
