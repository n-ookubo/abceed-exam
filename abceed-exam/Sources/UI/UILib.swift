//
//  UILib.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AlamofireImage
import Foundation
import UIKit

class UILib {
    
    private static let indicatorLock: NSLock = NSLock()
    private static let indicatorView: IndicatorView = IndicatorView()
    private static var indicatorVisible: Bool = false
    private static var indicatorViewConstraints: [NSLayoutConstraint] = []
    
    public static func showIndicatorView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        guard let window = windowScene.windows.first else {
            return
        }
        
        indicatorLock.lock()
        if indicatorVisible == false {
            window.addSubviewManual(indicatorView)
            
            indicatorViewConstraints = window.createSubviewConstraint(indicatorView)
            NSLayoutConstraint.activate(indicatorViewConstraints)
            
            indicatorView.startAnimating()
            
            indicatorVisible = true
        }
        indicatorLock.unlock()
    }
    
    public static func removeIndicatorView() {
        indicatorLock.lock()
        if indicatorVisible == true {
            indicatorView.stopAnimating()
            
            NSLayoutConstraint.deactivate(indicatorViewConstraints)
            indicatorView.removeFromSuperview()
            
            indicatorVisible = false
        }
        indicatorLock.unlock()
    }
}

extension UIView {
    func addSubviewManual(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}

extension UIImageView {
    func loadImageFromURL(string: String, successHandler: @escaping (UIImage)->Void) {
        if let url = URL(string: string) {
            self.af.setImage(withURL: url, cacheKey: string, completion:{
                (response: AFIDataResponse<UIImage>) in
                if let img = response.value {
                    ImageSizeCache.setImageSize(url: string, size: img.size)
                    successHandler(img)
                }
            })
        }
    }
}
