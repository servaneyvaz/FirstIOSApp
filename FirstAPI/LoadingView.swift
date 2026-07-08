//
//  LoadingView.swift
//  FirstAPI
//
//  Created by Servan on 28.06.26.
//

import UIKit

final class LoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configureIndicator()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureIndicator() {
        addSubview(activityIndicator)
        activityIndicator
            .centerX(centerXAnchor).0
            .centerY(centerYAnchor).0
            .width(widthAnchor).0
            .height(heightAnchor)
    }
    func configureColorIndicator(color: UIColor) {
        activityIndicator.color = color
    }
    func startAnimation() {
        activityIndicator.startAnimating()
    }
    func stopAnimation() {
        activityIndicator.stopAnimating()
    }
}
