//
//  LLSearchResult.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/24.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit



class LLSearchResult: NSObject {
    typealias resultblock = (_ str:LLSearchResult) -> Void
 
    var    totalitems:Int = 0
    var   categories:[String] = [String]()
    
    var  searchkey:String!
    
    var   comickids:[LLCategoryRecItem] = [LLCategoryRecItem]()
    var   hot:[LLCategoryRecItem] = [LLCategoryRecItem]()
    var   movietv:[LLCategoryRecItem] = [LLCategoryRecItem]()
    var   mv:[LLCategoryRecItem] = [LLCategoryRecItem]()
    var   sports:[LLCategoryRecItem] = [LLCategoryRecItem]()
    var   zongyi:[LLCategoryRecItem] = [LLCategoryRecItem]()
    static   func   searchwithkey(_ str:String, _ result:resultblock?){
        
        var   url = ""
        var  method:HTTPMethod!
        
        url = "http://open.moretv.com.cn/keyword?keyword="   +  str
         method = HTTPMethod.get
        
        let    asearchresult = LLSearchResult()
     
        LLAuthManager.Authorizon(url, method) { (data) in
            
            if data.data != nil {
            
            let  jsondata =  JSON(data: data.data! )
            asearchresult.searchkey = jsondata["searchkey"].string
            
            
            if  (jsondata["comickids"].array?.count)! > 0 {

                
                asearchresult.categories.append("少儿")
                asearchresult.totalitems =  asearchresult.totalitems + (jsondata["comickids"].array?.count)!
                for   item in (jsondata["comickids"].array)!{
                  
                   asearchresult.comickids.append(initialitem(item))
                }
                
                
                
                
                
            }
            if  (jsondata["hot"].array?.count)! > 0 {
                
                asearchresult.categories.append("热门")
                asearchresult.totalitems =  asearchresult.totalitems + (jsondata["hot"].array?.count)!
                for   item in (jsondata["hot"].array)!{
                    
                    asearchresult.hot.append(initialitem(item))
                }
                
                
                
            }
            if  (jsondata["movietv"].array?.count)! > 0 {
                
                asearchresult.categories.append("电影tv")
                asearchresult.totalitems =  asearchresult.totalitems + (jsondata["movietv"].array?.count)!
                for   item in (jsondata["movietv"].array)!{
                    
                    asearchresult.movietv.append(initialitem(item))
                }
                
            }
            if  (jsondata["mv"].array?.count)! > 0 {
                
                asearchresult.categories.append("mv")
                asearchresult.totalitems =  asearchresult.totalitems + (jsondata["mv"].array?.count)!
                for   item in (jsondata["mv"].array)!{
                    
                    asearchresult.mv.append(initialitem(item))
                }
                
            }
            if  (jsondata["sports"].array?.count)! > 0 {
                
                asearchresult.categories.append("体育")
                 asearchresult.totalitems =  asearchresult.totalitems + (jsondata["sports"].array?.count)!
                for   item in (jsondata["sports"].array)!{
                    
                    asearchresult.sports.append(initialitem(item))
                }
            }
            if  (jsondata["zongyi"].array?.count)! > 0 {
                
                asearchresult.categories.append("综艺")
                 asearchresult.totalitems =  asearchresult.totalitems + (jsondata["zongyi"].array?.count)!
                for   item in (jsondata["zongyi"].array)!{
                    
                    asearchresult.zongyi.append(initialitem(item))
                }
            }
            
            
            result!(asearchresult)
            
  
        }
    }
        
        
//
        
    }
    static   func   initialitem(_ json:JSON) -> LLCategoryRecItem {
        let  aitem = LLCategoryRecItem()
        
        aitem.erweicode = json
        aitem.item_tag = json["item_tag"].array
        aitem.item_area = json["item_area"].string
        aitem.item_cast = json["item_cast"].array
        aitem.item_director = json["item_director"].array
        
        
        
        aitem.item_guest = json["item_guest"].array
        aitem.item_host = json["item_host"].array
        
        aitem.link_data = json["link_data"].string
        aitem.item_contentType = json["item_contentType"].string
        aitem.item_score = json["item_score"].string
        aitem.item_episode = json["item_episode"].string
        aitem.item_icon1 = json["item_icon1"].string
        aitem.item_year = json["item_year"].string == "0" ? "未知":json["item_year"].string
        aitem.item_isHd = json["item_isHd"].string
        aitem.item_title = json["item_title"].string == nil ? "":json["item_title"].string
        aitem.tvurllink = String.gettvurl()
        
        return  aitem
        
    }
    
    
}
