//
//  YNSearch.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class YNSearch: NSObject {
    var pref: UserDefaults!
    
    open static let shared: YNSearch = YNSearch()

    public override init() {
        pref = UserDefaults.standard
    }
    
    open func setDatabase(value: [String]) {
        pref.set(value, forKey: "database")
    }
    
    open func getDatabase() -> [String]? {
        guard let database = pref.object(forKey: "database") as? [String] else { return nil }
        return database
    }
    
    open func getSearchResult(value: String) -> [String]? {
        guard let searchResult = pref.object(forKey: "database") as? [String] else { return nil }
        let predicate = NSPredicate(format: "SELF CONTAINS[c] %@", value)
        let searchDataSource = searchResult.filter { predicate.evaluate(with: $0) }

        return searchDataSource
    }

    
    open func setCategories(value: [String]) {
        pref.set(value, forKey: "categories")
    }
    
    open func getCategories() -> [String]? {
        guard let categories = pref.object(forKey: "categories") as? [String] else { return nil }
        return categories
    }


    open func setSearchHistories(value: [String]) {
        pref.set(value, forKey: "histories")
    }
    
    open func deleteSearchHistories(index: Int) {
        guard var histories = pref.object(forKey: "histories") as? [String] else { return }
        histories.remove(at: index)
        
        pref.set(histories, forKey: "histories")
    }
    
    open func appendSearchHistories(value: String) {
        var histories = [String]()
        if let _histories = pref.object(forKey: "histories") as? [String] {
            
            
            histories = _histories
        }
        if  !histories.contains(value){
          histories.append(value)

        pref.set(histories, forKey: "histories")
        }
    }
    
    open func getSearchHistories() -> [String]? {
        guard let histories = pref.object(forKey: "histories") as? [String] else { return nil }
        
        
        return histories
    }
    

}
extension  YNSearch{
    //
    open func getSearchRecentHistories(_ limit:Int) -> [String]? {
       let   histories =   getSearchHistories()
        
        
        
        if   histories != nil {
        if   limit  >=  (histories?.count)! {
            return  histories
        }
        else{
            var his = [String]()
            var  i = 0
            
            for  element in (histories?.reversed())!{
                if  i != limit{
                    i = i + 1
                    his.append(element)
                }
                else{
                    break
                }
            }
            
            return  his
            }
            
            
            
            
        }else{
            return  nil
        }
        
//        return  nil
        
    }
    
}
