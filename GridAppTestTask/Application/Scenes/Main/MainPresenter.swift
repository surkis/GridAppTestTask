import Foundation

protocol MainPresenter {
    var router: MainViewRouter { get }
    func needToLoadContent()
}

class MainPresenterImpl: MainPresenter {
    private weak var view: MainView?
    private(set) var router: MainViewRouter
    private let movieGateway: MovieGateway
    private var currentPoge: Int = 1
    
    init(view: MainView,
         router: MainViewRouter,
         movieGateway: MovieGateway) {
        self.view = view
        self.router = router
        self.movieGateway = movieGateway
    }
    
    func needToLoadContent() {
        
    }
    
    private func loadNextList(page: Int) {
        movieGateway.loadList(page: page) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(listReuslt):
                
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayError(messsage: error.localizedDescription)
                }
            }
        }
    }
}
