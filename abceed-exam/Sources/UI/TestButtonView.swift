//
//  testButtonView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class TestButtonView : UIView {
    static let buttonSize: CGFloat = 72.0
    static let iconSize: CGFloat = 40.0
    static let inset: CGFloat = 5.0
    
    private let iconView: UIImageView!
    private let label: UILabel!
    
    override init(frame: CGRect) {
        iconView = {
            let view = UIImageView(frame: frame)
            view.contentMode = .scaleAspectFit
            return view
        }()
        label = UI.label(12, color: Abceed.monotone1)
        
        super.init(frame: frame)
        
        backgroundColor = Abceed.monotone8
        layer.borderColor = Abceed.monotone6.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = TestButtonView.inset
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(type: BookTestType) {
        iconView.image = type.iconImage
        label.text = type.titleText
    }
    
    private func configureLayout() {
        addSubviewManual(iconView)
        addSubviewManual(label)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: TestButtonView.buttonSize),
            heightAnchor.constraint(equalToConstant: TestButtonView.buttonSize),
            iconView.widthAnchor.constraint(equalToConstant: TestButtonView.iconSize),
            iconView.heightAnchor.constraint(equalToConstant: TestButtonView.iconSize),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: TestButtonView.inset),
            iconView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -TestButtonView.inset),
            label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -TestButtonView.inset)
        ])
    }
}
