import UIKit

protocol BaseView: AnyObject {
    func displayError(messsage: String)
}

class BaseViewController: UIViewController, BaseView {

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

}
