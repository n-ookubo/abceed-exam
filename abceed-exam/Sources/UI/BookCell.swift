//
//  BookCell.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import Alamofire
import AlamofireImage
import UIKit

class BookCell : UICollectionViewCell {
    public static let ReuseIdentifier = String(describing: BookCell.self)
    
    private let imageView: UIImageView
    private var imageWidth: CGFloat = BookListView.bookCellHeight
    private var bookData: BookWrapper?
    
    override init(frame: CGRect) {
        imageView = {
            let view = UIImageView(frame: frame)
            view.contentMode = .scaleAspectFit
            view.clipsToBounds = true
            view.af.imageDownloader = NetworkLib.downloader()
            return view
        }()
        
        super.init(frame: frame)
        
        constrainSubview(imageView, horizontal: BookListView.bookCellInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.af.cancelImageRequest()
        imageView.image = nil
        bookData = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.frame.size = CGSize(width: imageWidth + BookListView.bookCellInset * 2, height: BookListView.bookCellHeight)
        return layoutAttributes
    }
    
    func configureCell(book: BookWrapper, layoutHandler: @escaping () -> Void) {
        bookData = book
        
        let initialImageWidth = calcImageWidth()
        imageWidth = initialImageWidth ?? BookListView.bookCellHeight
        
        imageView.loadImageFromURL(string: book.book.img_url) { image in
            if initialImageWidth == nil {
                // reconfigure cell
                DispatchQueue.main.async {
                    layoutHandler()
                }
            }
        }                              
    }
    
    private func calcImageWidth() -> CGFloat? {
        guard let book = bookData else { return nil }
        return ImageSizeCache.getImageWidth(url: book.book.img_url, imageHeight: BookListView.bookCellHeight)
    }
}
