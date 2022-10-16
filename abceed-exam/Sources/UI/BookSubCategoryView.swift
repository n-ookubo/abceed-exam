//
//  BookSubCategoryView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import UIKit

class BookSubCategoryView : UICollectionReusableView {
    private let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.baselineAdjustment = .alignCenters
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        constrainSubview(label, horizontal: BookListView.bookCategoryInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubCategoryName(name: String) {
        label.text = name
    }
}
