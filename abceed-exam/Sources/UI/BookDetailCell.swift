//
//  BookDetailCell.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class BookDetailCell : UICollectionViewCell {
    public static let ReuseIdentifier = String(describing: BookDetailCell.self)
    
    static let inset: CGFloat = 10.0
    
    private let detailView: BookDetailView = BookDetailView(frame: .zero)
    private let detailViewContainer: UIView = UIView()
    private let testView: BookTestView = BookTestView(frame: .zero)
    
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Abceed.monotone8
        detailViewContainer.backgroundColor = Abceed.monotone2
        testView.backgroundColor = Abceed.monotone4
        
        detailViewContainer.addSubviewManual(detailView)
        addSubviewManual(detailViewContainer)
        addSubviewManual(testView)
        
        NSLayoutConstraint.activate([
            detailView.centerXAnchor.constraint(equalTo: detailViewContainer.centerXAnchor),
            detailView.centerYAnchor.constraint(equalTo: detailViewContainer.centerYAnchor),
            detailView.topAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.topAnchor, constant: BookDetailCell.inset),
            detailView.leadingAnchor.constraint(greaterThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(lessThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.bottomAnchor, constant: -BookDetailCell.inset),
        ])
        
        NSLayoutConstraint.activate([
            detailView.widthAnchor.constraint(lessThanOrEqualToConstant: 450),
            //testView.widthAnchor.constraint(lessThanOrEqualToConstant: 363),
            testView.heightAnchor.constraint(equalToConstant: BookTestView.viewHeight),
        ])
        
        NSLayoutConstraint.activate([
            detailViewContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailViewContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailViewContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            detailViewContainer.bottomAnchor.constraint(equalTo: testView.topAnchor),
            
            //testView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            //testView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            testView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        detailView.resetView()
        bookData = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.frame.size.height = 400
        return layoutAttributes
    }
    
    func configureCell(data: BookWrapper) {
        bookData = data
        
        detailView.configureView(book: data)
    }
}
