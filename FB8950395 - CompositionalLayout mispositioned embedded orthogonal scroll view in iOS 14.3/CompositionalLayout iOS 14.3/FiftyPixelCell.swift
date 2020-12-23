//
//  FiftyPixelCell.swift
//  CompositionalLayout iOS 14.3
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

// MARK: A collection view cell that is 50 pixels high.
class FiftyPixelCell: UICollectionViewCell, Reusable, HeightSizable {
    var height: CGFloat = 50.0
    lazy var heightConstraint: NSLayoutConstraint = {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }()
}
