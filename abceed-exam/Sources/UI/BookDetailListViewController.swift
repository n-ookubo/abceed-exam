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
    
    private var processing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.constrainSubview(bookDetailListView)
                
        self.navigationController?.navigationBar.tintColor = Abceed.monotone1
        self.navigationItem.rightBarButtonItem = deleteButtonItem
        
        bookDetailListView.myBooksDelegate = self
        
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
        processing = false
    }
}

extension BookDetailListViewController : BookDetailListViewDelegate {
    func myBooksUpdateButtonPressed(of: BookWrapper?) {
        guard let book = of else { return }
        let bookId = book.book.id_book
        guard processing == false else { return }
        processing = true
        UILib.showIndicatorView()
        let curStatus = RealmLib.isMyBooks(bookId: bookId)
        let newStatus = !curStatus
        RealmLib.updateMyBooks(bookId: bookId, status: newStatus)
        bookDetailListView.refresh()
        UILib.removeIndicatorView()
        let message = newStatus ? "MyBookへ追加しました。" : "MyBookから削除しました。"
        let dialog = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            self.processing = false
        }))
        self.present(dialog, animated: true)
    }
}
