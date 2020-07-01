import Foundation

protocol MainPresenter {
    var router: MainViewRouter { get }
    func needToLoadContent()
}

class MainPresenterImpl: MainPresenter {
    private weak var view: MainView?
    private(set) var router: MainViewRouter
    
    init(view: MainView,
         router: MainViewRouter) {
        self.view = view
        self.router = router
    }
    
    func needToLoadContent() {
        
    }
}
