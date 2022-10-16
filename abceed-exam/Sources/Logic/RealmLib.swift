//
//  RealmLib.swift
//  abceed-exam
//
//  Created by Naoaki Okubo on 2022/10/16.
//

import Foundation
import RealmSwift

class MyBooksInfo : Object {
    @Persisted var bookId: String
    @Persisted var isMybooks: Bool
}

class RealmLib {
    
    static func isMyBooks(bookId: String) -> Bool {
        let realm = try! Realm()
        
        let result = realm.objects(MyBooksInfo.self).filter("bookId == %@", bookId)
        if result.count > 0 {
            let info = result.first!
            return info.isMybooks
        } else {
            return false
        }
    }
    
    static func updateMyBooks(bookId: String, status: Bool) {
        let realm = try! Realm()
        
        let result = realm.objects(MyBooksInfo.self).filter("bookId == %@", bookId)
        if result.count > 0 {
            let info = result.first!
            try! realm.write {
                info.isMybooks = status
            }
        } else {
            let info = MyBooksInfo()
            info.bookId = bookId
            info.isMybooks = status
            try! realm.write {
                realm.add(info)
            }
        }
    }
}
