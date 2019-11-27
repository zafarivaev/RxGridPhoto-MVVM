import UIKit
import RxSwift
import RxDataSources
import PKHUD

class GridViewController: UIViewController {
    
    let gridCellId = "GridCVCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        bindSectionsSubjectToCollectionView()
        getPhotos(isRefresh: false)
    }
    
    //MARK: - Actions
    @objc func refresh() {
        getPhotos(isRefresh: true)
    }
    
    //MARK: - Properties
    let disposeBag = DisposeBag()
    var viewModel = GridViewModel()
    var collectionView: UICollectionView!
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<SectionOfGridCellData>!
    let sectionsSubject = PublishSubject<[SectionOfGridCellData]>()
    let refreshControl = UIRefreshControl()
}

//MARK: UI Setup & Constraints
extension GridViewController {
    func setupUI() {
        setupCollectionView()
        registerCollectionViewCell()
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: Collection View Setup
extension GridViewController {
    func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout())
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(refreshControl)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth: CGFloat = SCREEN_WIDTH / 3.5
        let numberOfCells = floor(SCREEN_WIDTH / cellWidth)
        let edgeInsets = (SCREEN_WIDTH - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        layout.sectionInset = UIEdgeInsets(top: 10, left: edgeInsets, bottom: 0, right: edgeInsets)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        return layout
    }
    
    func registerCollectionViewCell() {
        let gridCellNib = UINib(nibName: gridCellId, bundle: nil)
        collectionView.register(gridCellNib, forCellWithReuseIdentifier: gridCellId)
    }
}

//MARK: - Collection View Binding
extension GridViewController {
    
    private func configureDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource(configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.gridCellId, for: indexPath) as! GridCVCell
            cell.photoURL = item.photoURL
            return cell
        })
    }
    
    private func bindSectionsSubjectToCollectionView() {
        sectionsSubject
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    private func getPhotos(isRefresh: Bool) {
        if !isRefresh {
            HUD.show(.labeledProgress(title: "Loading", subtitle: nil))
        }
        viewModel.getRandomPhotos(count: 30) { (photoModels) in
            HUD.hide()
            self.refreshControl.endRefreshing()
            self.sectionsSubject.onNext(photoModels ?? [])
        }
    }
 
}
