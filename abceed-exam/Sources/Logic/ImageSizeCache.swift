//
//  ImageSizeCache.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import Foundation

class ImageSizeCache {
    private static let imageSizeCache: NSMutableDictionary = NSMutableDictionary()
    
    public static func setImageSize(url: String, size: CGSize) {
        imageSizeCache.setValue(size, forKey: url)
    }
    public static func getImageSize(url: String) -> CGSize? {
        return imageSizeCache.value(forKey: url) as? CGSize
    }
    public static func getImageWidth(url: String, imageHeight: CGFloat) -> CGFloat? {
        guard let size = getImageSize(url: url) else { return nil }
        
        return imageHeight * size.width / size.height
    }
    public static func getImageHeight(url: String, imageWidth: CGFloat) -> CGFloat? {
        guard let size = getImageSize(url: url) else { return nil }
        
        return imageWidth * size.height / size.width
    }
}
