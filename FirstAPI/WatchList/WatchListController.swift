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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovies()
    }
    private func setupUI() {
        view.addSubview(collection)
        collection
            .top(view.safeAreaLayoutGuide.topAnchor, 20).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
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
                    self.collection.reloadData()
                }
            case .message(let text):
                print("Watchlist xətası və ya mesajı: \(text)")
            }
        }
    }
}

// MARK: - UICollectionView DataSource & Delegate
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
        let controller = MovieDetailController(viewModel: self.viewModel)
        navigationController?.pushViewController(controller, animated: true)
        controller.configure(id: viewModel.movies[indexPath.item].id ?? 0, data: viewModel.movies[indexPath.item].backdropPathURL, data1: viewModel.movies[indexPath.item].posterPathUrl, data2: viewModel.movies[indexPath.item].posterTitle, data3: viewModel.movies[indexPath.item].ratingAverage, data4: viewModel
            .movies[indexPath.item].aboutmovie)
    }
}
