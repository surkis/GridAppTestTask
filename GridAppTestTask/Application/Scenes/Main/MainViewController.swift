import UIKit

protocol MainView: BaseView {
    func displayTitle(title: String)
    func updateContent()
}

class MainViewController: BaseViewController, MainView {
     
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: properties
    private let refreshControl = UIRefreshControl()
    var presenter: MainPresenter!

    // MARK: life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.needToLoadContent()
        setupUIContent()
    }
    
    // MARK: sutup UI
    private func setupUIContent() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl
        collectionView.register(R.nib.mainItemCollectionViewCell)
        collectionView.register(R.nib.footerCollectionReusableView,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: display methods
    func displayTitle(title: String) {
        self.title = title
    }
    
    func updateContent() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc private func refreshData(_ sender: Any) {
        presenter.refreshData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(by: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let footerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: R.nib.footerCollectionReusableView,
            for: indexPath
        )!
        footerView.delegate = self
        return footerView
    }
}

// MARK: - extension: FooterCollectionViewDelegate
extension MainViewController: FooterCollectionViewDelegate {
    
    func didSelect(_ view: FooterCollectionReusableView) {
        presenter.actionMore()
    }
}
 
