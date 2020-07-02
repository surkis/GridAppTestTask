import Foundation

protocol DetailsPresenter {
    var router: DetailsViewRouter { get }
    func needToLoadContent()
}

class DetailsPresenterImpl: DetailsPresenter {
    var router: DetailsViewRouter
    private weak var view: DetailsView?
    private var model: MovieModel
    
    init(view: DetailsView, router: DetailsViewRouter, model: MovieModel) {
        self.view = view
        self.router = router
        self.model = model
    }
    
    func needToLoadContent() {
        view?.displayTitle(title: model.title)
        view?.displayBackground(imageURL: model.posterURL)
        showMovie()
    }
    
    private let yearFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy"
        return formater
    }()
    
    private let dateFormater: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "MMM dd, yyyy"
        return formater
    }()
    
    private func showMovie() {
        let year = yearFormater.string(from: model.releaseDate)
        let modelView = DetailsMovieModelView(
            name: "\(model.title) (\(year))",
            posterURL: model.posterURL,
            description: model.overview,
            rating: model.isAdult ? "R" : "G",
            score: "\(model.voteAverage)",
            releaseDateString: dateFormater.string(from: model.releaseDate))
        DispatchQueue.main.async {
            self.view?.displayContent(model: modelView)
        }
    }
}
