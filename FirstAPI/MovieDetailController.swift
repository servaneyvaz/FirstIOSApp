//
//  MovieDetailController.swift
//  FirstAPI
//
//  Created by Servan on 27.06.26.
//

import UIKit

final class MovieDetailController: UIViewController {
    private lazy var backPosterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var posterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var ratingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "ratingColor")
        view.layer.cornerRadius = 8
        
        return view
    }()
    private lazy var ratingStar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ratingstar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .orange
        return label
    }()
    private lazy var overview: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "About Movie"
        label.textColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapabout))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    private lazy var review: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Reviews"
        label.textColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapreview))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    private lazy var cast: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Cast"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapcast))
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var scrollLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "lineColor")
        return view
    }()
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        configure()
        setupCallbacks()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavbar()
        if let id = movieId {
                    viewModel.getAccountState(movieId: id) { [weak self] stateDto in
                        guard let self = self, let dto = stateDto else { return }
                        DispatchQueue.main.async {
                            self.isMovieInWatchlist = dto.isWatchlist
                        }
                    }
                }
    }
    private func setupCallbacks() {
        viewModel.callback = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.view.showLoading()
            case .loaded:
                self.view.hideLoading()
            case .reload:
                DispatchQueue.main.async {
                    self.isMovieInWatchlist.toggle()
                }
            case .message(let text):
                print("Mesaj: \(text)")
            }
        }
    }
    func configureNavbar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    private let viewModel: MovieListViewModel
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var movieId: Int?
    private var isMovieInWatchlist: Bool = false {
            didSet {
    
                saveButton.isSelected = isMovieInWatchlist
              
                saveButton.tintColor = isMovieInWatchlist ? .orange : .white
            }
        }
    @objc func addToWatchlist() {
            guard let id = movieId else { return }
            
            let targetState = !isMovieInWatchlist
           
            viewModel.addtoWatchlist(id: id, state: targetState)
        }
    
    @objc func backToHome() {
        navigationController?.popViewController(animated: true)
    }
    private lazy var backButton: UIButton = {
        let customBackButton = UIButton()
        customBackButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        customBackButton.tintColor = .white
        customBackButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        return customBackButton
    }()
    private lazy var saveButton: UIButton = {
        let customSaveButton = UIButton()
        customSaveButton.setImage(UIImage(named: "save")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white), for: .normal)
        customSaveButton.setImage(UIImage(named: "saved")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white), for: .selected
        )
        customSaveButton.addTarget(self, action: #selector(addToWatchlist), for: .touchUpInside)
        return customSaveButton
    }()
    func configure() {
        view.addSubviews(backPosterView,posterView,posterLabel,ratingView,ratingLabel,overview,review,cast,scrollLine,overviewLabel,backButton,saveButton)
        ratingView.addSubview(ratingStar)
        ratingStar
            .centerY(ratingView.centerYAnchor).0
            .leading(ratingView.leadingAnchor,8).0
            .width(16).0 .height(16)
        backPosterView
            .top(view.safeAreaLayoutGuide.topAnchor,60).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .height(210)
        posterView
            .centerY(backPosterView.bottomAnchor).0
            .leading(view.leadingAnchor, 30).0
            .width(100).0 .height(140)
        posterLabel
            .top(posterView.centerYAnchor,15).0
            .leading(posterView.trailingAnchor,15).0
            .trailing(view.trailingAnchor,-15)
        ratingView
            .bottom(backPosterView.bottomAnchor,-15).0
            .trailing(view.trailingAnchor,-15).0
            .width(60).0 .height(25)
        ratingLabel
            .leading(ratingStar.trailingAnchor,5).0
            .centerY(ratingStar.centerYAnchor)
        overview
            .top(posterView.bottomAnchor,35).0
            .leading(view.leadingAnchor, 35)
        review
            .top(posterView.bottomAnchor,35).0
            .leading(overview.trailingAnchor, 35)
        cast
            .top(posterView.bottomAnchor,35).0
            .leading(review.trailingAnchor, 35)
        scrollConstraint = scrollLine
            .top(cast.bottomAnchor,10).0
            .width(90).0 .height(4).0
            .leading(view.leadingAnchor, 35).1
        overviewLabel
            .top(scrollLine.bottomAnchor,15).0
            .leading(view.leadingAnchor, 35).0
            .trailing(view.trailingAnchor,-35)
        backButton
            .leading(view.leadingAnchor,10).0
            .top(view.safeAreaLayoutGuide.topAnchor,10).0
            .width(40).0 .height(40)
        saveButton
            .trailing(view.trailingAnchor,-10).0
            .top(view.safeAreaLayoutGuide.topAnchor,20).0
            .width(25).0 .height(25)
    }
    @objc func tapabout() {
        scrollConstraint.constant = 35
        overviewLabel.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapreview() {
        scrollConstraint.constant = 163
        overviewLabel.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapcast() {
        scrollConstraint.constant = 250
        overviewLabel.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func configure(id: Int,data: String?, data1: String?,data2: String?,data3: Double?,data4: String?) {
        self.movieId = id
        backPosterView.image = nil
        posterView.image = nil
        ratingLabel.text = nil
        posterLabel.text = nil
        overviewLabel.text = nil
        guard let data else { return }
        NetworkManager.shared.loadData(urlString: data, completion: {
            [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(let data):
                self.backPosterView.image = UIImage(data: data)
                
            case .failure(let error):
                    print(error)
            }
        })
        guard let data1 else { return }
        NetworkManager.shared.loadData(urlString: data1, completion: {
            [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(let data):
                self.posterView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        })
        if let data2 {
            posterLabel.text = data2
        }
        if let data3 {
            let rating = (data3 * 10).rounded()/10
            ratingLabel.text = "\(rating)"
        }
        if let data4 {
            overviewLabel.text = data4
        }
    }
    private var scrollConstraint: NSLayoutConstraint!
}
