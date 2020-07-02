import Foundation

protocol DetailsConfigurator {
    func configurePresenter(viewController: DetailsViewController) -> DetailsPresenter
}

class DetailsConfiguratorImpl: DetailsConfigurator {
    
    private var model: MovieModel
    
    init(model: MovieModel) {
        self.model = model
    }
    
    func configurePresenter(viewController: DetailsViewController) -> DetailsPresenter {
        let router = DetailsViewRouterImpl(viewController: viewController)
        
        return DetailsPresenterImpl(view: viewController,
                                    router: router,
                                    model: model)
    }
}
