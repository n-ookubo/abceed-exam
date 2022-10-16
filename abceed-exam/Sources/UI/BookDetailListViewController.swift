//
//  BookDetailListViewController.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import AbceedUILibrary
import UIKit

class BookDetailListViewController : UIViewController {
    private let bookDetailListView: BookDetailListView = BookDetailListView()
    private lazy var deleteButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "データ削除", style: .plain, target: nil, action: nil)
        button.tintColor = Abceed.myred
        return button
    }()
    
    private var bookData: BookWrapper?
    public var book: BookWrapper? {
        get { return bookData }
        set { bookData = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.constrainSubview(bookDetailListView)
                
        self.navigationController?.navigationBar.tintColor = Abceed.monotone1
        self.navigationItem.rightBarButtonItem = deleteButtonItem
        
        if let book = bookData {
            bookDetailListView.setBookData(data: book)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        UILib.removeIndicatorView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
