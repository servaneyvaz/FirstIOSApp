import UIKit

final class WatchListController: UIViewController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    private lazy var emptyWatchlistImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "emptywatchlist"))
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    private let viewModel: WatchListViewModel
    
    init(viewModel: WatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        setupUI()
        setupCallbacks()
        updateEmptyState()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovies()
       
    }
    private func updateEmptyState() {
        let isEmpty = viewModel.movies.isEmpty
        emptyWatchlistImage.isHidden = !isEmpty
        collection.isHidden = isEmpty
    }
    private func setupUI() {
        view.addSubviews(collection,emptyWatchlistImage)
        collection
            .top(view.safeAreaLayoutGuide.topAnchor, 20).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        emptyWatchlistImage
            .centerX(view.centerXAnchor).0
            .centerY(view.centerYAnchor).0
            .height(300).0
            .width(300)
    }
    private func setupCallbacks() {
        viewModel.callback = { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                self.view.showLoading()
            case .loaded:
                self.view.hideLoading()
            case .reload:
                DispatchQueue.main.async {
                    self.updateEmptyState()
                    self.collection.reloadData()
                    
                }
            case .message(let text):
                print("Watchlist xətası və ya mesajı: \(text)")
            }
        }
    }
}

extension WatchListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let cell = cell as? MovieCollectionCell {
            let movie = viewModel.movies[indexPath.item]
            cell.configure(data: movie.posterPathUrl)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - 24) / 3
        let cellHeight: CGFloat = cellWidth * 1.45
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
        let detailViewModel = DefaultMovieDetailViewModel(
            movie: movie,
            listViewModel: nil,
            watchlistModel: viewModel,
            isInWatchlist: true
        )
        let controller = MovieDetailController(viewModel: detailViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
