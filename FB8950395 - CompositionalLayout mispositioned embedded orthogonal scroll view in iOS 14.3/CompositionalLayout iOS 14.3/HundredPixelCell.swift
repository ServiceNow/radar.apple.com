//
//  HundredPixelCell.swift
//  CompositionalLayout iOS 14.3
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

// MARK: A collection view cell that is 100 pixels high.
class HundredPixelCell: UICollectionViewCell, Reusable, HeightSizable {
    var height: CGFloat = 100.0
    lazy var heightConstraint: NSLayoutConstraint = {
        let constraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }()
}
