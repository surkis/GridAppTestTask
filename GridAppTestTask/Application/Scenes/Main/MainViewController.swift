import UIKit

protocol MainView: BaseView {
    func displayTitle(title: String)
    func updateContent()
}

class MainViewController: BaseViewController, MainView {
     
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: properties
    var presenter: MainPresenter!

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.needToLoadContent()
        setupUIContent()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: sutup UI
    private func setupUIContent() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.mainItemCollectionViewCell)
    }
    
    // MARK: display methods
    func displayTitle(title: String) {
        self.title = title
    }
    
    func updateContent() {
        self.collectionView.reloadData()
    }
    
    // MARK: make method
    class func make(configurator: MainConfigurator) -> MainViewController {
        let mainVC = MainViewController()
        mainVC.presenter = configurator.configurePresenter(viewController: mainVC)
        return mainVC
    }

}

// MARK: - extension: UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainItemCollectionViewCell,
                                                      for: indexPath)!
        presenter.configure(cellView: cell, for: indexPath)
        return cell
    }

}
