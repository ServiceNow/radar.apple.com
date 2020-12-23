//
//  UICollectionViewCell+HeightSizable.swift
//  CompositionalLayout iOS 14.3
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

protocol HeightSizable where Self: UICollectionViewCell {
    var height: CGFloat { get }
    var heightConstraint: NSLayoutConstraint { get }
    func setup(with color: UIColor)
}

extension HeightSizable where Self: UICollectionViewCell {
    func setup(with color: UIColor) {
        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.constant = height
        setNeedsUpdateConstraints()
    }
}
