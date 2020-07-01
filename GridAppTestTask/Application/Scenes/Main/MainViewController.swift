import UIKit

protocol MainView: AnyObject {
    
}

class MainViewController: UIViewController, MainView {
    
    // MARK: properties
    var presenter: MainPresenter!

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.needToLoadContent()
    }
    
    // MARK: make method
    class func make(configurator: MainConfigurator) -> MainViewController {
        let mainVC = MainViewController()
        mainVC.presenter = configurator.configurePresenter(viewController: mainVC)
        return mainVC
    }

}
