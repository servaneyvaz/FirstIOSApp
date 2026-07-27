//
//  UIImageExtension.swift
//  FirstAPI
//
//  Created by Servan on 25.07.26.
//
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
