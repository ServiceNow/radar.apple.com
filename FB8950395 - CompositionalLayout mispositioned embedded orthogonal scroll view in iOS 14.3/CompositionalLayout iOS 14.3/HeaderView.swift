//
//  HeaderView.swift
//  CompositionalLayout iOS 14.3
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

class HeaderView: UICollectionReusableView, Reusable {
    lazy var label: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true

        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
          label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
          label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
          label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
          label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
}
