//
//  UICollectionView+Reusable.swift
//  CompositionalLayout
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        
        return cell
    }
    
    final func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath,
                                                                             viewType: T.Type = T.self) -> T where T: Reusable {
        guard let view = dequeueReusableSupplementaryView(ofKind: viewType.reuseIdentifier,
                                                          withReuseIdentifier: viewType.reuseIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Failed to dequeue a reusable supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self).")
        }
        
        return view
    }
    
    final func register<T: UICollectionReusableView>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forSupplementaryViewOfKind: cellType.reuseIdentifier, withReuseIdentifier: cellType.reuseIdentifier)
    }
}
