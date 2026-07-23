//
//  ReviewCell.swift
//  FirstAPI
//
//  Created by Servan on 23.07.26.
//

import UIKit

final class ReviewCell: UICollectionViewCell {
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byWordWrapping
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
        contentView.addSubviews(contentLabel)
        contentLabel
            .top(contentView.topAnchor).0
            .leading(contentView.leadingAnchor,24).0
            .trailing(contentView.trailingAnchor,-24).0
            .bottom(contentView.bottomAnchor)
    }
    func configureData(content: String) {
        contentLabel.text = content
    }
}
