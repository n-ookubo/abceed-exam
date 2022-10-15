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

extension UIView {
    /// subviewを四隅に貼り付ける制約を生成する。
    public func createSubviewConstraint(
        _ view: UIView,
        top: CGFloat = 0,
        bottom: CGFloat = 0,
        leading: CGFloat = 0,
        trailing: CGFloat = 0,
        againstSafeAreaOf edges: Set<Edge> = []
    ) -> [NSLayoutConstraint] {
        return [
            view.topAnchor.constraint(
                equalTo: edges.contains(.top) ? safeAreaLayoutGuide.topAnchor : topAnchor,
                constant: top
            ),
            view.bottomAnchor.constraint(
                equalTo: edges.contains(.bottom) ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor,
                constant: -bottom
            ),
            view.leadingAnchor.constraint(
                equalTo: edges.contains(.leading) ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor,
                constant: leading
            ),
            view.trailingAnchor.constraint(
                equalTo: edges.contains(.trailing) ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor,
                constant: -trailing
            ),
        ]
    }
}
