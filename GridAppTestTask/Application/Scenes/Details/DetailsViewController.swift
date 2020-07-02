import UIKit
import SDWebImage

protocol DetailsView: BaseView {
    func displayTitle(title: String)
    func displayBackground(imageURL: URL?)
    func displayContent(model: DetailsMovieModelView)
}

class DetailsViewController: BaseViewController, DetailsView {
    
    // MARK: IBOutlet
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    // MARK: properties
    var presenter: DetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPoster.sd_imageIndicator = SDWebImageActivityIndicator.gray
        presenter.needToLoadContent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imgBg.sd_cancelCurrentImageLoad()
        imgPoster.sd_cancelCurrentImageLoad()
    }
    
    // MARK: display methods
    func displayTitle(title: String) {
        self.title = title
    }
    
    func displayBackground(imageURL: URL?) {
        imgBg.sd_setImage(with: imageURL, completed: nil)
    }
    
    func displayContent(model: DetailsMovieModelView) {
        lblTitle.text = model.name
        lblDescription.text = model.description
        lblScore.text = model.score
        lblRating.text = model.rating
        lblReleaseDate.text = model.releaseDateString
        imgPoster.sd_setImage(with: model.posterURL, completed: nil)
    }

    // MARK: make method
    class func make(configurator: DetailsConfigurator) -> DetailsViewController {
        let detailsVC = DetailsViewController()
        detailsVC.presenter = configurator.configurePresenter(viewController: detailsVC)
        return detailsVC
    }
}
