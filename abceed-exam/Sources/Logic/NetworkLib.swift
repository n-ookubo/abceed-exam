//
//  NetworkLib.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import Alamofire
import AlamofireImage

class NetworkLib {
    static let apiBaseURL = "https://2zw3cqudp7.execute-api.ap-northeast-1.amazonaws.com/dev/"
    static let apiBookAll = "mock/book/all"
    
    private static var downloader_ = {
        return ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: AutoPurgingImageCache()
            )
    }()
    
    static func downloader() -> ImageDownloader {
        return downloader_
    }
    
    static func getAllBook(completionHandler: @escaping (DataResponse<TopCategoryList, AFError>) -> Void) {
        let url = apiBaseURL + apiBookAll
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: TopCategoryList.self, completionHandler: completionHandler)
    }
}
