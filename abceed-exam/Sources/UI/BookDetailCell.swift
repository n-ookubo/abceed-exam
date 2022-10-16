//
//  BookDetailCell.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import UIKit

class BookDetailCell : UICollectionViewCell {
    public static let ReuseIdentifier = String(describing: BookDetailCell.self)
    
    static let inset: CGFloat = 10.0
    
    private let detailView: BookDetailView = BookDetailView(frame: .zero)
    private let detailViewContainer: UIView = UIView()
    
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailViewContainer.addSubviewManual(detailView)
        constrainSubview(detailViewContainer)
        
        NSLayoutConstraint.activate([
            detailView.centerXAnchor.constraint(equalTo: detailViewContainer.centerXAnchor),
            detailView.centerYAnchor.constraint(equalTo: detailViewContainer.centerYAnchor),
            detailView.topAnchor.constraint(greaterThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(greaterThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(lessThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(lessThanOrEqualTo: detailViewContainer.safeAreaLayoutGuide.bottomAnchor),
            detailView.widthAnchor.constraint(lessThanOrEqualToConstant: 450),
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
