//
//  LLDownMovieItems.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/2.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLDownMovieItems: NSObject {
    //
    static  var  share = LLDownMovieItems()
    var   items = [LLCategoryRecItem]()
    
    override init() {
        super.init()
        
    }
    func  addmovieitem(_ item:LLCategoryRecItem) -> Bool{
    
       
        if  items.count == 0{
            
            items.append(item)
          
            
            let   task = LLDownMovieMananger(item)
            
            
            task.isdownloadsuccess = item.downloadsuccess
            var   identity = ""
            identity =  identity.appending(item.item_title!)
            
            identity = identity.appending(".mp4")
            task.identitystr = identity
            identity = ""
            if   LLDownMovieMananger.querytask(item, nil) == nil {
               return LLDownMovieMananger.additemanager(task)
                
            }
            
        }
        for  aitem in items{
            
            if  aitem.item_title == item.item_title || aitem.tvurllink == item.tvurllink {
                
                return  false
            }
           
        }
        items.append(item)
        
        let   task = LLDownMovieMananger(item)
        task.isdownloadsuccess = item.downloadsuccess
        var   identity = ""
        identity =  identity.appending(item.item_title!)
        
        identity = identity.appending(".mp4")
        task.identitystr = identity
        return   LLDownMovieMananger.additemanager(task)
    }
    func  removeitem(_ item:LLCategoryRecItem){
        
        let   pos = items.index { (aitem) -> Bool in
             return  aitem.item_title == item.item_title
        }
        if  pos != nil {
            items.remove(at: pos!)
        }
      
    }
}
