//
//  BookDetailView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

protocol BookDetailListViewDelegate {
    func myBooksUpdateButtonPressed(of: BookWrapper?)
}

class BookDetailListView : UICollectionView {
    public typealias DataSourceType = UICollectionViewDiffableDataSource<Int, BookWrapper>
    
    private var bookDetailDataSource: DataSourceType!
    private var bookData: BookWrapper?
    private var myBooksDelegate_: BookDetailListViewDelegate?
    public var myBooksDelegate : BookDetailListViewDelegate? {
        get { return myBooksDelegate_ }
        set { myBooksDelegate_ = newValue }
    }
    
    init(frame: CGRect = .zero) {
        let layout = BookDetailListView.createBookDetailViewLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = Abceed.monotone8
        register(BookCell.self, forCellWithReuseIdentifier: BookCell.ReuseIdentifier)
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setBookData(data: BookWrapper) {
        bookData = data
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, BookWrapper>()
        snapshot.appendSections([0])
        snapshot.appendItems([data], toSection: 0)
        bookDetailDataSource.apply(snapshot)
    }
    
    public func refresh() {
        guard let book = bookData else { return }
        var snapshot = bookDetailDataSource.snapshot()
        snapshot.reconfigureItems([book])
        bookDetailDataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BookDetailCell, BookWrapper> {
            (cell, indexPath, data) in
            // configure cell
            cell.configureCell(data: data) {
                book in
                if let delegate = self.myBooksDelegate {
                    delegate.myBooksUpdateButtonPressed(of: book)
                }
            }
        }
        
        bookDetailDataSource = DataSourceType(collectionView: self) {
            (collectionView, indexPath, item) in
            // ?????????????????????????????????????????????????????????????????????
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        dataSource = bookDetailDataSource
    }
    
    private static func createBookDetailViewLayout() -> UICollectionViewLayout {
        let estimatedHeight = 100.0
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(estimatedHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group);
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
