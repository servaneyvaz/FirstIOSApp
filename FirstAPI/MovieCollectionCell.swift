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
    private lazy var castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private lazy var castName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        contentView.addSubviews(imageView, castImageView , castName)
        imageView
            .top(contentView.topAnchor).0
            .leading(contentView.leadingAnchor).0
            .trailing(contentView.trailingAnchor).0
            .bottom(contentView.bottomAnchor)
        castImageView
            .top(contentView.topAnchor).0
            .leading(contentView.leadingAnchor).0
            .trailing(contentView.trailingAnchor).0
            .height(100)
        castName
            .top(imageView.bottomAnchor, 10).0
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
    func configureCast(data: String?) {
        castImageView.image = nil
        castName.text = nil
        guard let data else { return }
        NetworkManager.shared.loadData(urlString: data, completion: {
            [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(let data):
                castImageView.image = UIImage(data: data)
            case .failure(let error):
                    print(error)
            }
        })
    }
}
