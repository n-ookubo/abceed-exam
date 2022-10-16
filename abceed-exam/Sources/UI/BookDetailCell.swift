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
    static let defaultBookHeight: CGFloat = 200.0
    static let horizontalLeftWidth: CGFloat = 450.0
    static let horizontalRightWidth: CGFloat = 363.0
    static let horizontalWidth = horizontalLeftWidth + horizontalRightWidth + inset * 2.0
    
    private let detailView: BookDetailView = BookDetailView(frame: .zero)
    private let detailViewContainer: UIView = UIView()
    private let testView: BookTestView = BookTestView(frame: .zero)
    private let stackView: UIStackView = UIStackView(frame: .zero)
    
    private var verticalConstraints: [NSLayoutConstraint] = []
    private var horizontalConstraints: [NSLayoutConstraint] = []
    
    private var horizontalMode: Bool = false
    
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        testView.backgroundColor = Abceed.monotone7
        detailView.layer.borderColor = Abceed.monotone6.cgColor
        
        setupLayout ()
        configureVertical()
                
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
        guard let _ = bookData else {
            return layoutAttributes
        }
        configureLayout(frame: layoutAttributes.frame.size)
        
        layoutAttributes.frame.size.height = calcCellHeight()
        return layoutAttributes
    }
    
    func configureCell(data: BookWrapper, handler: ((BookWrapper?)->Void)?) {
        bookData = data
        
        detailView.configureView(book: data, handler: handler)
    }
    private func setupLayout() {
        detailViewContainer.addSubviewManual(detailView)
        
        stackView.addArrangedSubview(detailViewContainer)
        stackView.addArrangedSubview(testView)
        
        addSubviewManual(stackView)
        
        horizontalConstraints = [
            detailView.topAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.topAnchor, constant: BookDetailCell.inset),
            detailView.leadingAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.leadingAnchor, constant: BookDetailCell.inset),
            detailView.trailingAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.trailingAnchor, constant: -BookDetailCell.inset),
            detailView.bottomAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.bottomAnchor, constant: -BookDetailCell.inset),
            
            detailView.widthAnchor.constraint(equalToConstant: BookDetailCell.horizontalLeftWidth),
            testView.widthAnchor.constraint(equalToConstant: BookDetailCell.horizontalRightWidth),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: BookDetailCell.horizontalWidth),
            stackView.heightAnchor.constraint(equalToConstant: BookTestView.viewHeight),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: BookDetailCell.inset),
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ]
        
        verticalConstraints = [
            detailView.topAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.topAnchor, constant: BookDetailCell.inset),
            detailView.leadingAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: detailViewContainer.safeAreaLayoutGuide.bottomAnchor, constant: -BookDetailCell.inset),
            
            detailView.widthAnchor.constraint(equalToConstant: BookDetailCell.horizontalLeftWidth).priority(.defaultLow),
            testView.heightAnchor.constraint(equalToConstant: BookTestView.viewHeight),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ]
    }
    private func configureLayout(frame: CGSize) {
        let prevHorizontal = horizontalMode
        horizontalMode = frame.width > BookDetailCell.horizontalWidth
        
        if prevHorizontal != horizontalMode {
            if horizontalMode {
                configureHorizontal()
            } else {
                configureVertical()
            }
        }
    }
    private func configureHorizontal() {
        backgroundColor = Abceed.monotone7
        detailViewContainer.backgroundColor = Abceed.monotone7
        
        detailView.layer.borderWidth = 1.0
        detailView.layer.cornerRadius = 5.0
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0.0
        
        NSLayoutConstraint.deactivate(verticalConstraints)
        NSLayoutConstraint.activate(horizontalConstraints)
    }
    private func configureVertical() {
        backgroundColor = Abceed.monotone8
        detailViewContainer.backgroundColor = Abceed.monotone8
        
        detailView.layer.borderWidth = 0.0
        detailView.layer.cornerRadius = 0.0
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0.0
        
        NSLayoutConstraint.deactivate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }
    private func calcCellHeight() -> CGFloat {
        var bookHeight: CGFloat = BookDetailCell.defaultBookHeight
        if let book = bookData {
            bookHeight = ImageSizeCache.getImageHeight(url: book.book.img_url, imageWidth: BookDetailView.bookImageWidth) ?? BookDetailCell.defaultBookHeight
        }
        let upperHeight = max(bookHeight + BookDetailView.inset * 2, detailView.frame.height) + BookDetailCell.inset * 2
        let lowerHeight = BookTestView.viewHeight
        if horizontalMode {
            return max(upperHeight, lowerHeight) + BookDetailCell.inset * 2.5
        } else {
            return upperHeight + lowerHeight
        }
    }
}
