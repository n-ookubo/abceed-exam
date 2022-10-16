//
//  BookDetailCell.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import UIKit

class BookDetailCell : UICollectionViewCell {
    public static let ReuseIdentifier = String(describing: BookDetailCell.self)
    
    private let detailView: BookDetailView = BookDetailView(frame: .zero)
    
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailView.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailView.widthAnchor.constraint(equalToConstant: 200),
            detailView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookData = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.frame.size.height = 400
        return layoutAttributes
    }
    
    func configureCell(data: BookWrapper) {
        bookData = data
    }
}
