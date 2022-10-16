//
//  UILib.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
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

extension UI {
    public enum ButtonStyle : Int {
        case redBorder = 0
        case redBody
        case gray
        public var foregroundColor: UIColor {
            switch self {
            case .redBorder: return Abceed.myred
            case .redBody: return Abceed.monotone8
            case .gray: return Abceed.monotone3
            }
        }
        public var backgroundColor: UIColor {
            switch self {
            case .redBorder: return Abceed.monotone8
            case .redBody: return Abceed.myred
            case .gray: return Abceed.monotone8
            }
        }
        public var borderColor: UIColor {
            switch self {
            case .redBorder: return Abceed.myred
            case .redBody: return Abceed.myred
            case .gray: return Abceed.monotone3
            }
        }
        public var configBase: UIButton.Configuration {
            switch self {
            case .redBorder: return UIButton.Configuration.plain()
            case .redBody: return UIButton.Configuration.filled()
            case .gray: return UIButton.Configuration.plain()
            }
        }
    }
    
    public static func buttonConfig(
        style: ButtonStyle,
        title: String? = nil,
        fontSize: CGFloat = 12.0,
        fontWeight: UIFont.Weight = .regular,
        buttonSize: UIButton.Configuration.Size = .small,
        borderWidth: CGFloat = 1.0,
        borderRadius: CGFloat = 5.0
    ) -> UIButton.Configuration {
        
        var config = style.configBase
        
        if let str = title {
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
            config.attributedSubtitle = AttributedString(str, attributes: container )
        }
        config.titleAlignment = .center
        config.baseBackgroundColor = style.backgroundColor
        config.baseForegroundColor = style.foregroundColor
        config.background.strokeColor = style.borderColor
        config.background.strokeWidth = borderWidth
        config.background.cornerRadius = borderRadius
        config.buttonSize = buttonSize
        
        return config
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
