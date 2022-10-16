//
//  BookSubCategoryView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class BookSubCategoryView : UICollectionReusableView {
    private let label: UILabel!
    
    override init(frame: CGRect) {
        label = {
            let label = UI.label(18, weight: .bold, color: Abceed.monotone1)
            label.baselineAdjustment = .alignCenters
            label.adjustsFontForContentSizeCategory = true
            return label
        }()
        
        super.init(frame: frame)
        
        constrainSubview(label, horizontal: BookListView.bookCategoryInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubCategoryName(name: String) {
        label.text = name
    }
}
