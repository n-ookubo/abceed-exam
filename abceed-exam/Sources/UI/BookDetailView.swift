//
//  BookDetailView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import AlamofireImage
import UIKit

class BookDetailView : UIView {
    static let bookImageWidth: CGFloat = 90.0
    static let buttonHeight: CGFloat = 20.0
    static let inset: CGFloat = 5.0
    static let fontSize: CGFloat = 14.0
    
    static let autherTitle: String = "著者"
    static let publisherTitle: String = "出版社"
    static let leftButtonTitle: String = "MyBooks追加"
    static let leftButtonTitleSelected: String = "MyBooksから外す"
    static let rightButtonTitle: String = "読み放題中"
    
    private let imageView: UIImageView
    private var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let bookNameLabel: UILabel!
    
    private let authorLabel: UILabel!
    private let authorLayout: BulletTextLayout!
    
    private let publisherLabel: UILabel!
    private let publisherLayout: BulletTextLayout!
    
    private let buttonStackView: UIStackView!
    private let buttonLeftContainer: UIStackView!
    private let buttonRightContainer: UIStackView!
    
    private let buttonLeft: UIButton!
    private let buttonRight: UIButton!
    
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        imageView = {
            let view = UIImageView(frame: frame)
            view.contentMode = .scaleAspectFit
            view.clipsToBounds = true
            view.af.imageDownloader = NetworkLib.downloader()
            return view
        }()
        bookNameLabel = UI.label(BookDetailView.fontSize, weight: .bold, color: Abceed.monotone1)
        authorLabel = UI.label(BookDetailView.fontSize, weight: .light, color: Abceed.monotone2)
        publisherLabel = UI.label(BookDetailView.fontSize, weight: .light, color: Abceed.monotone2)
        [bookNameLabel, authorLabel, publisherLabel].forEach {
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
        authorLayout = BulletTextLayout(TitleLabel(BookDetailView.autherTitle), spacing: BookDetailView.inset, rightElement: authorLabel, rightTextFontSize: BookDetailView.fontSize)
        publisherLayout = BulletTextLayout(TitleLabel(BookDetailView.publisherTitle), spacing: BookDetailView.inset, rightElement: publisherLabel, rightTextFontSize: BookDetailView.fontSize)
        
        buttonStackView = {
            let view = UIStackView(frame: frame)
            view.axis = .horizontal
            view.distribution = .fillEqually
            view.alignment = .fill
            view.spacing = 0.0
            return view
        }()
        buttonLeftContainer = UIStackView(frame: frame)
        buttonRightContainer = UIStackView(frame: frame)
        [buttonLeftContainer, buttonRightContainer].forEach {
            $0?.axis = .horizontal
            $0?.distribution = .fill
            $0?.alignment = .fill
            $0?.spacing = 0.0
        }
        [buttonStackView, buttonLeftContainer, buttonRightContainer].forEach {
            $0?.backgroundColor = UIColor.clear
        }
        buttonLeft = {
            let button = UIButton()
            button.configuration = UI.buttonConfig(style: .redBorder, title: BookDetailView.leftButtonTitle)
            return button
        }()
        buttonRight = {
            let button = UIButton()
            button.configuration = UI.buttonConfig(style: .redBody, title: BookDetailView.rightButtonTitle)
            return button
        }()
        
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(book: BookWrapper) {
        bookData = book        
        
        let initialImageHeight = calcImageHeight()
        let imageHeight = initialImageHeight ?? BookDetailView.bookImageWidth
        imageViewHeightConstraint.constant = imageHeight
        
        imageView.loadImageFromURL(string: book.book.img_url) { image in
            if initialImageHeight == nil {
                if let newImageHeight = self.calcImageHeight() {
                    DispatchQueue.main.async {
                        self.imageViewHeightConstraint.constant = newImageHeight
                    }
                }
            }
        }
        
        bookNameLabel.text = book.book.name_book
        authorLabel.text = book.book.author
        publisherLabel.text = book.book.publisher
        debugPrint(book)
    }
    
    func resetView() {
        imageView.af.cancelImageRequest()
        imageView.image = nil
        
        bookNameLabel.text = nil
        authorLabel.text = nil
        publisherLabel.text = nil
        
        bookData = nil
    }
    
    private func calcImageHeight() -> CGFloat? {
        guard let book = bookData else { return nil }
        return ImageSizeCache.getImageHeight(url: book.book.img_url, imageWidth: BookDetailView.bookImageWidth)
    }
    
    private func createUIObjects() {
        
    }
    private func configureLayout() {
        backgroundColor = Abceed.monotone8
        
        
        addSubviewManual(imageView)
        addSubviewManual(bookNameLabel)
        addSubviewManual(authorLayout)
        addSubviewManual(publisherLayout)
        addSubviewManual(buttonStackView)
        
        buttonStackView.addArrangedSubview(buttonLeftContainer)
        buttonStackView.addArrangedSubview(buttonRightContainer)
        
        buttonLeftContainer.addArrangedSubview(buttonLeft)
        buttonLeftContainer.addArrangedSubview(UIView.spacer(width: BookDetailView.inset))
        buttonRightContainer.addArrangedSubview(UIView.spacer(width: BookDetailView.inset))
        buttonRightContainer.addArrangedSubview(buttonRight)
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: BookDetailView.bookImageWidth)
        
        NSLayoutConstraint.activate([
            // imageView position
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: BookDetailView.inset),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: BookDetailView.inset),
            // imageView size
            imageView.widthAnchor.constraint(equalToConstant: BookDetailView.bookImageWidth),
            imageViewHeightConstraint,
            // bookNameLabel position
            bookNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: BookDetailView.inset),
            bookNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: BookDetailView.inset * 2),
            bookNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -BookDetailView.inset),
            // authorLayout posion
            authorLayout.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: BookDetailView.inset),
            authorLayout.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: BookDetailView.inset * 2),
            authorLayout.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -BookDetailView.inset),
            // publisherLayout posion
            publisherLayout.topAnchor.constraint(equalTo: authorLayout.bottomAnchor, constant: BookDetailView.inset),
            publisherLayout.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: BookDetailView.inset * 2),
            publisherLayout.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -BookDetailView.inset),
            // buttonStackView posion
            buttonStackView.topAnchor.constraint(equalTo: publisherLayout.bottomAnchor, constant: BookDetailView.inset),
            buttonStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: BookDetailView.inset * 2),
            buttonStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -BookDetailView.inset),
            // buttonStackView size
            buttonStackView.heightAnchor.constraint(equalToConstant: BookDetailView.buttonHeight),
            // bottom
            buttonStackView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -BookDetailView.inset).priority(.defaultLow),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -BookDetailView.inset)
        ])
    }
}
