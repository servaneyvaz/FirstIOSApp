//
//  ReviewController.swift
//  FirstAPI
//
//  Created by Servan on 23.07.26.
//
import UIKit

final class ReviewController: UIViewController {
    
    private var reviewList: [MoviePresentable] = []
    
    func update(with review: [MoviePresentable]) {
        self.reviewList = review
        reviewCollectionView.reloadData()
    }
    
    
    
    private lazy var reviewCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: "reviewcell")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        reviewCollectionView.reloadData()
    }
   func configure() {
        view.addSubviews(reviewCollectionView)
        
       reviewCollectionView
           .top(view.safeAreaLayoutGuide.topAnchor).0
           .leading(view.leadingAnchor).0
           .trailing(view.trailingAnchor).0
           .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        
    }
}
extension ReviewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewcell", for: indexPath)
        if let cell = cell as? ReviewCell {
            cell.configureData(content: reviewList[indexPath.item].contentOfMovie ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        24
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        18
    }
}
