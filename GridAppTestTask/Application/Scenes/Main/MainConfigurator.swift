import Foundation

protocol MainConfigurator {
    func configurePresenter(viewController: MainViewController) -> MainPresenter
}

class MainConfiguratorImpl: MainConfigurator {
    func configurePresenter(viewController: MainViewController) -> MainPresenter {
        let router = MainViewRouterImpl(viewController: viewController)
        
        return MainPresenterImpl(view: viewController, router: router)
    }
}
