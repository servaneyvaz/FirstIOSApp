//
//  UIView_extension.swift
//  FirstAPI
//
//  Created by Servan on 28.06.26.
//
import UIKit
extension UIView {
    func showLoading(size: CGSize = CGSizeMake(50, 50), color: UIColor = .systemGray) {
        subviews.forEach {
            if let loadingView = $0 as? LoadingView {
                loadingView.stopAnimation()
                loadingView.removeFromSuperview()
            }
        }
        let loadingView = LoadingView()
        addSubview(loadingView)
        loadingView
            .centerX(centerXAnchor).0
            .centerY(centerYAnchor).0
            .width(size.width).0 .height(size.height)
        loadingView.configureColorIndicator(color: color)
        loadingView.startAnimation()
    }
    func hideLoading() {
        subviews.forEach {
            if let loadingView = $0 as? LoadingView {
                loadingView.stopAnimation()
                loadingView.removeFromSuperview()
            }
        }
    }
}
