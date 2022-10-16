//
//  BookTestView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class BookTestView : UIView {
    static let viewHeight: CGFloat = TestButtonView.buttonSize * 2.0 + BookTestView.inset * 3.0
    static let inset: CGFloat = 10.0
    
    private let upperStackView: UIStackView!
    private let lowerStackView: UIStackView!
    private let verticalStackView: UIStackView!
    
    override init(frame: CGRect) {
        upperStackView = UIStackView(frame: frame)
        lowerStackView = UIStackView(frame: frame)
        verticalStackView = UIStackView(frame: frame)
        [upperStackView, lowerStackView, verticalStackView].forEach {
            $0?.axis = .horizontal
            $0?.distribution = .equalSpacing
            $0?.alignment = .center
            $0?.spacing = 10.0
        }
        verticalStackView.axis = .vertical
        
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureLayout() {
        addSubviewManual(upperStackView)
        addSubviewManual(lowerStackView)
        
        upperStackView.addArrangedSubview(UI.testButton(type: .contents))
        upperStackView.addArrangedSubview(UI.testButton(type: .mockExamTest))
        upperStackView.addArrangedSubview(UI.testButton(type: .sound))
        upperStackView.addArrangedSubview(UI.testButton(type: .sw))
        
        lowerStackView.addArrangedSubview(UI.testButton(type: .vocabs))
        lowerStackView.addArrangedSubview(UI.testButton(type: .marksheet))
        lowerStackView.addArrangedSubview(UI.testButton(type: .handRecord))
        lowerStackView.addArrangedSubview(UIView.spacer(width: TestButtonView.buttonSize, height: TestButtonView.buttonSize))
        
        verticalStackView.addArrangedSubview(upperStackView)
        verticalStackView.addArrangedSubview(lowerStackView)
        
        constrainSubview(verticalStackView, horizontal: BookTestView.inset, vertical: BookTestView.inset)
    }
}
