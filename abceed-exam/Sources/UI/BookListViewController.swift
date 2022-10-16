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
    
    private var processing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bookListView.delegate = self
        view.constrainSubview(bookListView)
                
        self.navigationItem.title = "書籍詳細"
        
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.processing = false
    }

}

extension BookListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let bookListView = collectionView as? BookListView else { return }
        guard let item = bookListView.itemIdentifier(for: indexPath) else { return }
        guard processing == false else { return }
        
        processing = true
        
        UILib.showIndicatorView()
        
        let controller = BookDetailListViewController()
        controller.book = item
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

