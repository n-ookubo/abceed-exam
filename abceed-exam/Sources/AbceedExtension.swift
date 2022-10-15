//
//  AbceedExtension.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

struct TopCategoryList : Codable {
    let top_category_list: Array<TopCategory>
}

struct TopCategory : Codable {
    let id_top_category: String
    let name_category: String
    let sub_category_list: Array<SubCategory>
}

struct SubCategory : Codable {
    let id_category: String
    let name_category: String
    let book_list: Array<Book>
}

extension Abceed where Base: UIColor {
    public static var myred: UIColor { .init(named: "MyRed")! }
}
