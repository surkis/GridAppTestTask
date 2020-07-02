import UIKit

protocol MainView: BaseView {
    
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
    
    // MARK: make method
    class func make(configurator: MainConfigurator) -> MainViewController {
        let mainVC = MainViewController()
        mainVC.presenter = configurator.configurePresenter(viewController: mainVC)
        return mainVC
    }

}

// MARK: - extension: UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mainItemCollectionViewCell,
                                                      for: indexPath)!
        
        return cell
    }

}
