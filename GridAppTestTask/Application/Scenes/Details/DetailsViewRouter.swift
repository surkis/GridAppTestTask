import Foundation

protocol DetailsViewRouter {
    
}

class DetailsViewRouterImpl: DetailsViewRouter {
    
    private weak var viewController: DetailsViewController?
    
    init(viewController: DetailsViewController) {
        self.viewController = viewController
    }
}
