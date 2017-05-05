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
    
    
    
    func  removeitem(_ item:LLCategoryRecItem) -> Bool{
           var   result = false
        for   i in 0..<items.count{
            
             let  aitem  = items[i]
            if  aitem.item_title == item.item_title{
                
                items.remove(at: i)
                result = true
               
            }
            
        }
        return  result
    }
}
