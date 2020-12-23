//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Jeroen Wesbeek on 23/12/2020.
//

import UIKit

class ViewController: UIViewController {
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = self.generateDataSource()
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(cellType: FiftyPixelCell.self)
            collectionView.register(cellType: HundredPixelCell.self)
            collectionView.register(cellType: HeaderView.self)
            collectionView.collectionViewLayout = generateLayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applySnapshot(animatingDifferences: true)
    }
}

// MARK: - Compositional Layout
private extension ViewController {
    func generateLayout() -> UICollectionViewCompositionalLayout {
        // Generate section layouts that are always estimated as 50 pixels high.
        UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            
            let height = section.height
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: height)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
            
            // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: height)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            // Section
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.orthogonalScrollingBehavior = .continuous
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            // Section header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: HeaderView.reuseIdentifier,
                                                                            alignment: .top)
            layoutSection.boundarySupplementaryItems = [sectionHeader]
            
            return layoutSection
        }
    }
}

// MARK: - Diffable DataSources
private extension ViewController {
    func generateDataSource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            
            switch section {
            case .first, .third:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FiftyPixelCell.self)
                cell.setup(with: section.color)
                return cell
            case .second, .fourth:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HundredPixelCell.self)
                cell.setup(with: section.color)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = {
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            let view = collectionView.dequeueReusableSupplementaryView(for: indexPath, viewType: HeaderView.self)
            view.label.text = Section(rawValue: indexPath.section)?.label
            return view
        }

        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        for section in Section.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(section.items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
