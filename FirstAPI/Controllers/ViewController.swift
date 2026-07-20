import UIKit

class ViewController: UIViewController {
    
    private lazy var collection4: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell4")
        return collection
    }()
    
   
    private lazy var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "mainCell")
        return collection
    }()
    
    private lazy var scrollLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineColor")
        return view
    }()
    
    private lazy var npLabel: UILabel = {
        let label = UILabel()
        label.text = "Now Playing"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getNowPlayingMovies))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        return label
    }()
    
    private lazy var ucLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getupcomingMovies))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        return label
    }()
    
    private lazy var trLabel: UILabel = {
        let label = UILabel()
        label.text = "Top rated"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getTopRatedMovies))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        return label
    }()
    
    private lazy var ppLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(getPopularMovies))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var searchField: UITextField = {
        let searchBar = UITextField()
        searchBar.textColor = .white
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)
        searchBar.backgroundColor = UIColor(named: "searchColor")
        searchBar.layer.cornerRadius = 20
        
        let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        let containerView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        iconView.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        containerView.addSubview(iconView)
        searchBar.rightView = containerView
        searchBar.leftView = containerView1
        searchBar.rightViewMode = .always
        searchBar.leftViewMode = .always
        return searchBar
    }()
    
    private let viewModel: [MovieListViewModel]
    private var scrollConstraint: NSLayoutConstraint!
    
 
    private var selectedIndex: Int = 0
    
    init(viewModel: [MovieListViewModel]) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        navigationController?.setNavigationBarHidden(true, animated: false)
        configure()
        callBackConfigure()
        
        
        viewModel.forEach { $0.getMovies() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func callBackConfigure() {
        viewModel.forEach { vm in
            vm.callback = { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    self.view.showLoading()
                case .loaded:
                    self.view.hideLoading()
                case .message(let message):
                    print(message)
                case .reload:
                    DispatchQueue.main.async {
                        self.collection4.reloadData()
                        self.mainCollection.reloadData()
                    }
                }
            }
        }
    }
    
    func configure() {
        view.addSubviews(mainCollection, npLabel, scrollLine, ucLabel, trLabel, ppLabel, collection4, welcomeLabel, searchField)
        
        mainCollection
            .top(view.safeAreaLayoutGuide.topAnchor, 430).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
        collection4
            .top(view.safeAreaLayoutGuide.topAnchor, 100).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor, -24).0
            .bottom(npLabel.topAnchor, -25)
        
        npLabel
            .bottom(mainCollection.topAnchor, -40).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24)
        
        ucLabel
            .bottom(mainCollection.topAnchor, -40).0
            .leading(npLabel.trailingAnchor, 14)
        
        trLabel
            .bottom(mainCollection.topAnchor, -40).0
            .leading(ucLabel.trailingAnchor, 14)
        
        ppLabel
            .bottom(mainCollection.topAnchor, -40).0
            .leading(trLabel.trailingAnchor, 14)
        
        scrollConstraint = scrollLine
            .top(npLabel.bottomAnchor, 10).0
            .width(90).0 .height(4).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor, 24).1
            
        welcomeLabel
            .top(view.safeAreaLayoutGuide.topAnchor).0
            .leading(view.leadingAnchor, 35)
            
        searchField
            .top(welcomeLabel.bottomAnchor, 10).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(collection4.topAnchor, -10)
    }
    
    
    @objc func getNowPlayingMovies() {
        switchTab(toIndex: 0, scrollConstant: 24)
    }
    
    @objc func getupcomingMovies() {
        switchTab(toIndex: 1, scrollConstant: 130)
    }
    
    @objc func getTopRatedMovies() {
        switchTab(toIndex: 2, scrollConstant: 220)
    }
    
    @objc func getPopularMovies() {
        switchTab(toIndex: 3, scrollConstant: 300)
    }
    
    private func switchTab(toIndex: Int, scrollConstant: CGFloat) {
        selectedIndex = toIndex
        viewModel[selectedIndex].getMovies()
        scrollConstraint.constant = scrollConstant
        mainCollection.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collection4 {
            let cellWidth: CGFloat = (collectionView.frame.width - 40) / 2
            return CGSize(width: cellWidth, height: cellWidth * 1.45)
        } else {
            let cellWidth: CGFloat = (collectionView.frame.width - 24) / 3
            return CGSize(width: cellWidth, height: cellWidth * 1.45)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection4 {
          
            return viewModel[4].movies.count
        } else {
         
            return viewModel[selectedIndex].movies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! MovieCollectionCell
            let movie = viewModel[4].movies[indexPath.row]
            cell.configure(data: movie.posterPathUrl)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MovieCollectionCell
            let movie = viewModel[selectedIndex].movies[indexPath.row]
            cell.configure(data: movie.posterPathUrl)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentViewModel: MovieListViewModel
        let movie: MoviePresentable
        
        if collectionView == collection4 {
            currentViewModel = viewModel[4]
            movie = viewModel[4].movies[indexPath.item]
        } else {
            currentViewModel = viewModel[selectedIndex]
            movie = viewModel[selectedIndex].movies[indexPath.item]
        }
        
        let controller = MovieDetailController(viewModel: currentViewModel)
        navigationController?.pushViewController(controller, animated: true)
        
        controller.configure(
            id: movie.id ?? 0,
            data: movie.backdropPathURL,
            data1: movie.posterPathUrl,
            data2: movie.posterTitle,
            data3: movie.ratingAverage,
            data4: movie.aboutmovie, release: movie.releaseDate?.split(separator: "-").first.map(String.init)
            
        )
    }
}
