import Foundation
import CoreGraphics

protocol MainPresenter {
    var router: MainViewRouter { get }
    func needToLoadContent()
    func numberOfSections() -> Int
    func numberOfRows(section: Int) -> Int
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath)
}

class MainPresenterImpl: MainPresenter {
    private weak var view: MainView?
    private(set) var router: MainViewRouter
    private let movieGateway: MovieGateway
    private var currentPoge: Int = 1
    private var models: [MovieModel] = []
    
    init(view: MainView,
         router: MainViewRouter,
         movieGateway: MovieGateway) {
        self.view = view
        self.router = router
        self.movieGateway = movieGateway
    }
    
    func needToLoadContent() {
        view?.displayTitle(title: R.string.localizable.main_page_title())
        loadList(page: currentPoge)
    }
    
    private func loadList(page: Int) {
        movieGateway.loadList(page: page) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case let .success(listReuslt):
                print("listReuslt:", listReuslt)
                self.addMovies(listReuslt.results)
            case let .failure(error):
                DispatchQueue.main.async {
                    self.view?.displayError(messsage: error.localizedDescription)
                }
            }
        }
    }
    
    private func addMovies(_ movies: [MovieModel]) {
        self.models += movies
        DispatchQueue.main.async {
            self.view?.updateContent()
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return models.count
    }
    
    func configure(cellView: BaseViewModelCellType, for indexPath: IndexPath) {
        guard let mainCell = cellView as? MainItemCellType else {
            return
        }
        let model = models[indexPath.row]
        let modelView = MovieItemModelView(identifier: model.identifier, posterURL: model.posterURL)
        mainCell.setup(viewModel: modelView)
    }
}
