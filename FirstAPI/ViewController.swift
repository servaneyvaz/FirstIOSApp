//
//  ViewController.swift
//  FirstAPI
//
//  Created by Servan on 09.06.26.
//

import UIKit

class ViewController: UIViewController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    private lazy var collection1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell1")
        return collection
    }()
    private lazy var collection2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell2")
        return collection
    }()
    private lazy var collection3: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell3")
        return collection
    }()
    private lazy var collection4: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = false
        collection.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "cell4")
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
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.lightGray]
        
            searchBar.attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: placeholderAttributes
            )
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        navigationController?.setNavigationBarHidden(true, animated: false)
        configure()
        callBackConfigure()
        viewModel.forEach {
            $0.getMovies()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    private func callBackConfigure() {
        viewModel.forEach({
            $0.callback = { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    self.view.showLoading()
                case .loaded:
                    self.view.hideLoading()
                case .message(let message):
                    
                    print(message)
                case .reload:
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        
                        let collections = [self.collection1, self.collection2, self.collection3, self.collection4, self.collection]
                        collections.forEach { $0.reloadData() }
                    }
                }
            }
        })
    }
    func configure() {
        view.addSubviews(collection,npLabel,scrollLine,ucLabel,trLabel,ppLabel,collection1,collection2,collection3,collection4,welcomeLabel,searchField)
        collection
            .top(view.safeAreaLayoutGuide.topAnchor,430).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor,-24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        collection1
            .top(view.safeAreaLayoutGuide.topAnchor,430).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor,-24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        collection2
            .top(view.safeAreaLayoutGuide.topAnchor,430).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor,-24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        collection3
            .top(view.safeAreaLayoutGuide.topAnchor,430).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor,-24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        collection4
            .top(view.safeAreaLayoutGuide.topAnchor,100).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).0
            .trailing(view.safeAreaLayoutGuide.trailingAnchor,-24).0
            .bottom(npLabel.topAnchor,-25)
        npLabel
            .bottom(collection.topAnchor,-40).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24)
        ucLabel
            .bottom(collection.topAnchor,-40).0
            .leading(npLabel.trailingAnchor,14)
        trLabel
            .bottom(collection.topAnchor,-40).0
            .leading(ucLabel.trailingAnchor,14)
        ppLabel
            .bottom(collection.topAnchor,-40).0
            .leading(trLabel.trailingAnchor,14)
        scrollConstraint = scrollLine
            .top(npLabel.bottomAnchor,10).0
            .width(90).0 .height(4).0
            .leading(view.safeAreaLayoutGuide.leadingAnchor,24).1
        welcomeLabel
            .top(view.safeAreaLayoutGuide.topAnchor).0
            .leading(view.leadingAnchor,35)
        searchField
            .top(welcomeLabel.bottomAnchor,10).0
            .leading(view.leadingAnchor,24).0
            .trailing(view.trailingAnchor,-24).0
            .bottom(collection4.topAnchor,-10)
    }
    @objc func getupcomingMovies() {
        viewModel.forEach({
            $0.getMovies()
        })
        collection.isHidden = true
        collection2.isHidden = true
        collection3.isHidden = true
        collection1.isHidden = false
        scrollConstraint.constant = 130
        collection1.reloadData()
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() }
        )
    }
    @objc func getNowPlayingMovies() {
        viewModel.forEach({
            $0.getMovies()
        })
        collection.isHidden = false
        collection1.isHidden = true
        collection2.isHidden = true
        collection3.isHidden = true
        scrollConstraint.constant = 24
        collection.reloadData()
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() }
        )
    }
    @objc func getTopRatedMovies() {
        viewModel.forEach({
            $0.getMovies()
        })
        collection.isHidden = true
        collection1.isHidden = true
        collection2.isHidden = false
        collection3.isHidden = true
        scrollConstraint.constant = 220
        collection2.reloadData()
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() }
        )
    }
    @objc func getPopularMovies() {
        viewModel.forEach({
            $0.getMovies()
        })
        collection.isHidden = true
        collection1.isHidden = true
        collection2.isHidden = true
        collection3.isHidden = false
        scrollConstraint.constant = 300
        collection2.reloadData()
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() }
        )
    }
    private let viewModel: [MovieListViewModel]
    init(viewModel: [MovieListViewModel]) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var scrollConstraint: NSLayoutConstraint!
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collection4 {
            let cellWidth: CGFloat = (collectionView.frame.width - 40) / 2
            let cellHeight: CGFloat = cellWidth * 1.45
            return CGSizeMake(cellWidth, cellHeight)
        }
        else {
            let cellWidth: CGFloat = (collectionView.frame.width - 24) / 3
            let cellHeight: CGFloat = cellWidth * 1.45
            return CGSizeMake(cellWidth, cellHeight)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection {
            return viewModel[0].movies.count
        } else if collectionView == collection1 {
            return viewModel[1].upcomingMovies.count
        }
        else if collectionView == collection2 {
            return viewModel[2].topRatedMovies.count
        }
        else if collectionView == collection3 {
            return viewModel[3].popularMovies.count
        }
        else if collectionView == collection4 {
            return viewModel[4].trendMovies.count
        }
        else {
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if let cell = cell as? MovieCollectionCell {
                cell.configure(data: viewModel[0].movies[indexPath.row].posterPathUrl)
            }
            return cell
        } else if collectionView == collection1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            if let cell = cell as? MovieCollectionCell {
                cell.configure(data: viewModel[1].upcomingMovies[indexPath.row].posterPathURL)
            }
            return cell
        }
        else if collectionView == collection2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            if let cell = cell as? MovieCollectionCell {
                cell.configure(data: viewModel[2].topRatedMovies[indexPath.row].posterpathUrl)
            }
            return cell
        }
        else if collectionView == collection3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
            if let cell = cell as? MovieCollectionCell {
                cell.configure(data: viewModel[3].popularMovies[indexPath.row].posterPathUrl)
            }
            return cell
        }
        else if collectionView == collection4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath)
            if let cell = cell as? MovieCollectionCell {
                cell.configure(data: viewModel[4].trendMovies[indexPath.row].posterPathUrl)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedViewModel: MovieListViewModel
        let id: Int
        let backdrop: String?
        let poster: String?
        let title: String?
        let rating: Double?
        let about: String?
        if collectionView == collection {
            selectedViewModel = viewModel[0]
            let movie = viewModel[0].movies[indexPath.item]
            id = movie.id ?? 0; backdrop = movie.backdropPathURL; poster = movie.posterPathUrl; title = movie.posterTitle; rating = movie.ratingAverage; about = movie.aboutmovie
        } else if collectionView == collection1 {
            selectedViewModel = viewModel[1]
            let movie = viewModel[1].upcomingMovies[indexPath.item]
            id = movie.id ?? 0; backdrop = movie.backdropPathURL; poster = movie.posterPathURL; title = movie.posterTitle; rating = movie.ratingAverage; about = movie.aboutmovie
        } else if collectionView == collection2 {
            selectedViewModel = viewModel[2]
            let movie = viewModel[2].topRatedMovies[indexPath.item]
            id = movie.id ?? 0; backdrop = movie.backdropPathURL; poster = movie.posterpathUrl; title = movie.posterTitle; rating = movie.ratingAverage; about = movie.aboutmovie
        } else if collectionView == collection3 {
            selectedViewModel = viewModel[3]
            let movie = viewModel[3].popularMovies[indexPath.item]
            id = movie.id ?? 0; backdrop = movie.backdropPathURL; poster = movie.posterPathUrl; title = movie.posterTitle; rating = movie.ratingAverage; about = movie.aboutmovie
        } else if collectionView == collection4 {
            selectedViewModel = viewModel[4]
            let movie = viewModel[4].trendMovies[indexPath.item]
            id = movie.id ?? 0; backdrop = movie.backdropPathURL; poster = movie.posterPathUrl; title = movie.posterTitle; rating = movie.ratingAverage; about = movie.aboutmovie
        } else {
            return
        }
        let controller = MovieDetailController(viewModel: selectedViewModel)
        navigationController?.pushViewController(controller, animated: true)
        controller.configure(id: id, data: backdrop, data1: poster, data2: title, data3: rating, data4: about)
    }
}
