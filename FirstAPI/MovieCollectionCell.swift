//
//  MovieCollectionCell.swift
//  FirstAPI
//
//  Created by Servan on 26.06.26.
//

import UIKit

final class MovieCollectionCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        contentView.addSubview(imageView)
        imageView
            .top(contentView.topAnchor).0
            .leading(contentView.leadingAnchor).0
            .trailing(contentView.trailingAnchor).0
            .bottom(contentView.bottomAnchor)
    }
    func configure(data: String?) {
        imageView.image = nil
        guard let data else { return }
        NetworkManager.shared.loadData(urlString: data, completion: {
            [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(let data):
                imageView.image = UIImage(data: data)
            case .failure(let error):
                    print(error)
            }
        })
    }
}
