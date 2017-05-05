//
//  LLCollectItem.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
extension   JSON {
    
    static    func  jsonarrtonsarray(_ jsonarr:[JSON]?) -> NSArray{
        let   arrs = NSMutableArray(capacity: 0)
        if   jsonarr == nil {
            return  arrs
        }
        for  arr in  jsonarr!{
            
            arrs.add(arr.string! as  String)
            
            
        }
        
        
        return   arrs.copy() as!  NSArray
        
        
        
        
    }
    static    func  arrtonJson(_ jsonarr:NSArray!) -> [JSON]{
        var   arrs = [JSON]()
        
        for  arr in  jsonarr{
            let   ar = JSON.init(arr)
            
            arrs.append(ar)
            
            
            
        }
        
        
        return   arrs
    }
    
    
}


class LLCollectItem: BmobObject {
    
    var   collectuser:BmobObject!
    //  附带
    var  erweicode:JSON!
    var  tvurllink:String!
     var  downloaded:Bool = false
    var  iswatched:Bool = false
    var  iscollected:Bool = false
    var  item_director:NSArray!//导演
    var   item_cast:NSArray!//主演
    var   item_tag:NSArray!//标签
    var   item_guest:NSArray!
    var   item_host:NSArray!
    var   item_area:String!//地区
    var item_contentType:String!//影片类型
    var   item_score:String! //评分
    
    var   link_data:String!
    
    
    var   item_episode:String!
    var   item_icon1:String! //影片图片
    
    var   item_isHd:String!
    var   item_year:String!//年份
    var   item_title:String!//名称
    
    
    
    //  下方接口:bmob
    static   func   itemwithobj(_ obj:BmobObject) -> LLCollectItem{
        let  newitem  = LLCollectItem(className: "LLCategoryRecItem")
        newitem?.objectId = obj.objectId
        newitem?.createdAt = obj.createdAt
        newitem?.updatedAt = obj.updatedAt
        newitem?.tvurllink  = obj.object(forKey: "tvurllink") as? String
        
        newitem?.item_contentType = obj.object(forKey: "item_contentType") as? String
        newitem?.item_score = obj.object(forKey: "item_score") as? String
        newitem?.item_score = obj.object(forKey: "item_score") as? String
        newitem?.link_data = obj.object(forKey: "link_data") as? String
        newitem?.item_episode = obj.object(forKey: "item_episode") as? String
        newitem?.item_icon1 = obj.object(forKey: "item_icon1") as! String
        newitem?.item_isHd = obj.object(forKey: "item_isHd") as? String
        newitem?.item_year = obj.object(forKey: "item_year") as? String
        newitem?.item_title = obj.object(forKey: "item_title") as? String
        newitem?.item_area = obj.object(forKey: "item_area") as? String
        let   arr = obj.object(forKey: "item_director")  as?  NSArray
        newitem?.item_director =    arr == nil  ? NSArray():arr
        let   arr1 = obj.object(forKey: "item_cast")  as?  NSArray
        newitem?.item_cast =    arr1 == nil  ? NSArray():arr1
        let   arr2 = obj.object(forKey: "item_tag")  as?  NSArray
        newitem?.item_tag =    arr2 == nil  ? NSArray():arr2
        
        let   arr3 = obj.object(forKey: "item_guest")  as?  NSArray
        newitem?.item_guest =    arr2 == nil  ? NSArray():arr3
        
        let   arr4 = obj.object(forKey: "item_host")  as?  NSArray
        newitem?.item_host =    arr4 == nil  ? NSArray():arr4
        
        let  userobj = obj.object(forKey: "collectuser") as!  BmobObject
        newitem?.collectuser = userobj
        
        let    watch = obj.object(forKey: "iswatched") as?  Bool
        if  watch == nil {
             newitem?.iswatched = false
            
            
        }
            
            
        else{
               newitem?.iswatched = watch!
        }
        
//        let    downloaded = obj.object(forKey: "downloaded") as?  Bool
//        if  watch == nil {
//            newitem?.downloaded = false
//            
//            
//        }
//            
//            
//        else{
//            newitem?.downloaded = downloaded!
//        }
        
        let    collected = obj.object(forKey: "iscollected") as?  Bool
        if  collected == nil {
            newitem?.iscollected = false
            
            
        }
        else{
            newitem?.iscollected = collected!
            
        }
        
        
        return   newitem!
    }
    func   trancategorieitem() -> LLCategoryRecItem{
        
        let   cateitem = LLCategoryRecItem()
        cateitem.collectuser = self.collectuser
        
        cateitem.tvurllink = self.tvurllink
        cateitem.item_title = self.item_title
        cateitem.item_title = self.item_title
        cateitem.item_area = self.item_area
        cateitem.item_contentType = self.item_contentType
        cateitem.item_score = self.item_score
        cateitem.link_data = self.link_data
        cateitem.item_episode = self.item_episode
        cateitem.item_icon1 = self.item_icon1
        cateitem.item_isHd = self.item_isHd
        cateitem.item_year = self.item_year
        cateitem.item_director = JSON.arrtonJson(self.item_director)
        cateitem.item_cast = JSON.arrtonJson(self.item_cast)
        cateitem.item_tag = JSON.arrtonJson(self.item_tag)
        
        cateitem.item_guest = JSON.arrtonJson(self.item_guest)
        cateitem.item_host = JSON.arrtonJson(self.item_host)
        cateitem.item_guest = JSON.arrtonJson(self.item_guest)
        cateitem.objectId = self.objectId
         cateitem.iswatched = self.iswatched
        cateitem.iscollected = self.iscollected
        return   cateitem
    }
    
    
    
    
}
