import UIKit

class CastController: UIViewController {
    
    
    private let castViewModels: [MovieListViewModel]
   
    private var pages: [UIViewController] = []
    
  
    init(castViewModels: [MovieListViewModel]) {
        self.castViewModels = castViewModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        configure()
    }
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageViewController
    }()
    
    private func setupPages() {
        let castVC = CastViewController(castList: castViewModels.first?.persons ?? [])
        pages = [castVC]
        
        if let firstPage = pages.first {
            pageViewController.setViewControllers([firstPage], direction: .forward, animated: false, completion: nil)
        }
    }
    func configure() {
        addChild(pageViewController)
        view.addSubviews(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        
        pageViewController.view
                .leading(view.leadingAnchor).0
                .trailing(view.trailingAnchor).0
                .top(view.topAnchor).0
                .bottom(view.bottomAnchor)
    }
}
final class CastViewController: UIViewController {
    
    private var castList: [MoviePresentable] = []
    
    init(castList: [MoviePresentable]) {
        self.castList = castList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        castCollection.dataSource = self
        castCollection.delegate = self
        
        castCollection.reloadData()
    }
    
    private lazy var castCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cast")
        collection.backgroundColor = .clear
        return collection
    }()
    
    func configure() {
        view.addSubviews(castCollection)
        castCollection
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .bottom(view.bottomAnchor).0
            .top(view.topAnchor)
    }
}

extension CastViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast", for: indexPath)
        
        if indexPath.row < castList.count {
            let person = castList[indexPath.row]
            if let cell = cell as? MovieCollectionCell {
                cell.configureCast(data: person.profilePath)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height > 20 ? collectionView.frame.height - 20 : 100
        return CGSize(width: height * 0.8, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
