import UIKit

enum DetailPage {
    case cast
    case review
}

class DetailPageController: UIViewController {

    private let viewModel: CastListViewModel
    private let viewModelReview: ReviewViewModel
    private var pages: [UIViewController] = []
    private let castVC = CastViewController()
    private let reviewVC = ReviewController()
    private var currentPage: DetailPage = .review
    
    init(movieId: Int) {
        self.viewModel = DefaultCastListViewModel(movieId: movieId)
        self.viewModelReview = DefaultReviewViewModel(movieId: movieId)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupPages()
        bind()
        viewModel.getCast()
        viewModelReview.getReviews()
    }

    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        return pageViewController
    }()

    private func setupPages() {
        pages = [castVC,reviewVC]
        pageViewController.setViewControllers([reviewVC], direction: .forward, animated: false, completion: nil)
    }
    func showPage(_ page: DetailPage) {
        guard page != currentPage else { return }
        let targetVC: UIViewController = page == .cast ? castVC : reviewVC
        let direction: UIPageViewController.NavigationDirection = page == .cast ? .forward : .reverse
        currentPage = page
        pageViewController.setViewControllers([targetVC], direction: direction, animated: true, completion: nil)
    }

    private func bind() {
        viewModel.callback = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading, .loaded:
                break
            case .reload:
                DispatchQueue.main.async {
                    self.castVC.update(with: self.viewModel.cast)
                    self.reviewVC.update(with: self.viewModelReview.review)
                }
            case .message(let text):
                print("Xəta: \(text)")
            }
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

extension DetailPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        currentPage = pages[index - 1] === castVC ? .cast : .review
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        currentPage = pages[index + 1] === castVC ? .cast : .review
        return pages[index + 1]
    }
}

final class CastViewController: UIViewController {
    
    private var castList: [MoviePresentable] = []
    
    init() {
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
    
    func update(with cast: [MoviePresentable]) {
        castList = cast
        castCollection.reloadData()
    }
    
    private lazy var castCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cast")
        collection.backgroundColor = .clear
        return collection
    }()
    
    func configure() {
        view.addSubviews(castCollection)
        castCollection
            .leading(view.leadingAnchor,24).0
            .trailing(view.trailingAnchor,-24).0
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
                cell.configureCast(data: person.profilePathURL, name: person.namePath ?? "0")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 34
    }
}
