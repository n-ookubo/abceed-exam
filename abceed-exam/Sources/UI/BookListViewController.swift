//
//  ViewController.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import Alamofire
import UIKit

class BookListViewController: UIViewController {
    private let bookListView: BookListView = BookListView()
    private var categoryList: TopCategoryList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.constrainSubview(bookListView)
        
        
        UILib.showIndicatorView()
        NetworkLib.getAllBook { (response: DataResponse<TopCategoryList, AFError>) in
            var succeeded = false
            switch response.result {
            case .success:
                if let list = response.value {
                    self.categoryList = list
                    if let subCategory = list.top_category_list.first {
                        self.bookListView.setTopCategoryData(data: subCategory)
                        succeeded = true
                    }
                }
            case .failure:
                succeeded = false
            }
            
            UILib.removeIndicatorView()
            
            if !succeeded {
                let dialog = UIAlertController(title: "エラー", message: "書籍情報の取得に失敗しました。", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(dialog, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

}

