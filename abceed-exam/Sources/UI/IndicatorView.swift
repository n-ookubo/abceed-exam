//
//  IndicatorView.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class IndicatorView : UIView {
    
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let containerView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Abceed.monotone1.withAlphaComponent(0.4)
        
        indicator.hidesWhenStopped = false
        
        containerView.backgroundColor = Abceed.monotone4
        containerView.layer.cornerRadius = 10
        containerView.addSubviewManual(indicator)
        self.addSubviewManual(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 100),
            containerView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
}
