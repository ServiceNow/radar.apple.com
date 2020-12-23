//
//  Section.swift
//  CompositionalLayout iOS 14.3
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

enum Section: Int, CaseIterable {
    case first, second, third, fourth
    
    var items: [Item] {
        (0..<20).map { Item(id: self.rawValue * 100 + $0) }
    }
    
    var height: NSCollectionLayoutDimension {
        switch self {
        case .first, .second:
            return .estimated(50)
        case .third, .fourth:
            return .estimated(100)
        }
    }
    
    var color: UIColor {
        switch self {
        case .first, .third:
            return .green
        case .second, .fourth:
            return .red
        }
    }
    
    var label: String {
        switch self {
        case .first:
            return "FiftyPixelCell, height: 50"
        case .second:
            return "FiftyPixelCell, height: 100"
        case .third:
            return "HundredPixelCell, height: 50"
        case .fourth:
            return "HundredPixelCell, height: 100"
        }
    }
}
