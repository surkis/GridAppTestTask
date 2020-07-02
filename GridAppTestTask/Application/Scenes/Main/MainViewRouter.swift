import UIKit

protocol MainViewRouter {
    func showDetails(by model: MovieModel)
}

class MainViewRouterImpl: MainViewRouter {
    
    private weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showDetails(by model: MovieModel) {
        let configurator = DetailsConfiguratorImpl(model: model)
        let vc = DetailsViewController.make(configurator: configurator)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
