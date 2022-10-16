//
//  BookListView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class BookListView : UICollectionView {
    public typealias DataSourceType = UICollectionViewDiffableDataSource<SubCategory, BookWrapper>
    
    static let bookCategoryElementKind: String = "sub-category-header-element-kind"
    static let bookCategoryHeight: CGFloat = 44.0
    static let bookCategoryInset: CGFloat = 10.0
    static let bookCellHeight: CGFloat = 160.0
    static let bookCellInset: CGFloat = 5.0
    
    private var bookViewDataSource: DataSourceType!
    private var topCategoryData: TopCategory?
    
    init(frame: CGRect = .zero) {
        let layout = BookListView.createBookViewLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = Abceed.monotone8
        register(BookCell.self, forCellWithReuseIdentifier: BookCell.ReuseIdentifier)
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTopCategoryData(data: TopCategory) {
        topCategoryData = data
        
        var snapshot = NSDiffableDataSourceSnapshot<SubCategory, BookWrapper>()
        snapshot.appendSections(data.sub_category_list)
        for category in data.sub_category_list {
            let books = BookWrapper.createBookList(subCategory: category)
            snapshot.appendItems(books, toSection: category)
        }
        bookViewDataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BookCell, BookWrapper> {
            (cell, indexPath, data) in
            // configure cell
            cell.configureCell(book: data) {
                var snapshot = self.bookViewDataSource.snapshot()
                snapshot.reconfigureItems([data])
                self.bookViewDataSource.apply(snapshot)
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<BookSubCategoryView>(elementKind: BookListView.bookCategoryElementKind) {
            (header, string, indexPath) in
            
            guard let topCategory = self.topCategoryData else { return }
            guard indexPath.section < topCategory.sub_category_list.count else { return }
            let category = topCategory.sub_category_list[indexPath.section]
            
            // configure header
            header.setSubCategoryName(name: category.name_category)
        }
        
        bookViewDataSource = DataSourceType(collectionView: self) {
            (collectionView, indexPath, item) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        bookViewDataSource.supplementaryViewProvider = {
            (view, kind, index) in
            return view.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        dataSource = bookViewDataSource
    }
    
    private static func createBookViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(bookCellHeight), heightDimension: .absolute(bookCellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: bookCellInset, leading: 0.0, bottom: bookCellInset, trailing: 0.0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(bookCellHeight), heightDimension: .absolute(bookCellHeight + bookCellInset * 2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group);
        section.orthogonalScrollingBehavior = .continuous
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(bookCategoryHeight))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: bookCategoryElementKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
