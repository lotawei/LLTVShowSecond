//
//  LLCollectListManager.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLCollectListManager: NSObject {
    
    
    static var  share = LLCollectListManager()
    
    var  collectionitems:[LLCollectItem]  = [LLCollectItem]()
    var watcheditems:[LLCollectItem]  = [LLCollectItem]()
    
    func  isexistuser()  -> Bool {
        
        let   curuser = LLCurrentUser.currentuser.user
        return curuser  == nil  ?  false:true
    }
    //  添加收藏 传入 观看为true
    func  additem(_ iswatched:Bool,_ item:LLCategoryRecItem,_  result:@escaping BmobBooleanResultBlock){
        if  isexistuser() {
            let   curuser = LLCurrentUser.currentuser.user
            let  bobuser = BmobObject(className: "_User")
            bobuser?.objectId = curuser?.objectid
            
            
            
            let   aitem =  BmobObject(className: "LLCategoryRecItem")
            aitem?.setObject(item.item_area, forKey: "item_area")
            aitem?.setObject(item.item_title, forKey: "item_title")
            aitem?.setObject(item.item_contentType, forKey: "item_contentType")
            aitem?.setObject(item.item_score, forKey: "item_score")
            aitem?.setObject(item.link_data, forKey: "link_data")
            aitem?.setObject(item.item_episode, forKey: "item_episode")
            aitem?.setObject(item.item_icon1, forKey: "item_icon1")
            aitem?.setObject(item.item_isHd, forKey: "item_isHd")
            aitem?.setObject(item.item_year, forKey: "item_year")
            aitem?.setObject(item.tvurllink, forKey: "tvurllink")
            let   direcarr = JSON.jsonarrtonsarray(item.item_director )
            aitem?.setObject(direcarr, forKey: "item_director")
            
            let   castcarr = JSON.jsonarrtonsarray(item.item_cast )
            aitem?.setObject(castcarr, forKey: "item_cast")
            
            let  item_tagarr = JSON.jsonarrtonsarray(item.item_tag)
            aitem?.setObject(item_tagarr, forKey: "item_tag")
            
            let  item_guestarr = JSON.jsonarrtonsarray(item.item_guest)
            aitem?.setObject(item_guestarr, forKey: "item_guest")
            let  item_hostarr = JSON.jsonarrtonsarray(item.item_host)
            aitem?.setObject(item_hostarr, forKey: "item_host")
            aitem?.setObject(bobuser, forKey: "collectuser")
            if   iswatched == true {
                aitem?.setObject(true, forKey: "iswatched")
            }
            else{
                
                aitem?.setObject(true, forKey: "iscollected")
                
                
            }
            weak   var   tmp = self
            
            aitem?.sub_saveInBackground(resultBlock: { (su, err) in
                
                
                
                
                tmp?.queryitems()
                
                
                
                result(su,err)
            })
            
        }
        
        
    }
    //重复添加时 只需更新数据库字段
    func   updateitem(_ item:LLCategoryRecItem,_  result:@escaping BmobBooleanResultBlock ){
        if  isexistuser() {
            
            let   curuser = LLCurrentUser.currentuser.user
            let  bobuser = BmobObject(className: "_User")
            bobuser?.objectId = curuser?.objectid
            let   aitem =  BmobObject(className: "LLCategoryRecItem")
            aitem?.setObject(item.item_area, forKey: "item_area")
            aitem?.setObject(item.item_title, forKey: "item_title")
            aitem?.setObject(item.item_contentType, forKey: "item_contentType")
            aitem?.setObject(item.item_score, forKey: "item_score")
            aitem?.setObject(item.link_data, forKey: "link_data")
            aitem?.setObject(item.item_episode, forKey: "item_episode")
            aitem?.setObject(item.item_icon1, forKey: "item_icon1")
            aitem?.setObject(item.item_isHd, forKey: "item_isHd")
            aitem?.setObject(item.item_year, forKey: "item_year")
            aitem?.setObject(item.tvurllink, forKey: "tvurllink")
            let   direcarr = JSON.jsonarrtonsarray(item.item_director )
            aitem?.setObject(direcarr, forKey: "item_director")
            
            let   castcarr = JSON.jsonarrtonsarray(item.item_cast )
            aitem?.setObject(castcarr, forKey: "item_cast")
            
            let  item_tagarr = JSON.jsonarrtonsarray(item.item_tag)
            aitem?.setObject(item_tagarr, forKey: "item_tag")
            
            let  item_guestarr = JSON.jsonarrtonsarray(item.item_guest)
            aitem?.setObject(item_guestarr, forKey: "item_guest")
            let  item_hostarr = JSON.jsonarrtonsarray(item.item_host)
            aitem?.setObject(item_hostarr, forKey: "item_host")
            aitem?.setObject(bobuser, forKey: "collectuser")
            
            aitem?.setObject(item.iswatched, forKey: "iswatched")
            
            
            
            aitem?.setObject(item.iscollected, forKey: "iscollected")
            let  bmobquery = BmobQuery(className: "LLCategoryRecItem")
            bmobquery?.whereKey("collectuser", equalTo: bobuser)
            bmobquery?.whereKey("item_title", equalTo: item.item_title)
            bmobquery?.includeKey("collectuser")
            
          
            bmobquery?.findObjectsInBackground({ (arr, err) in
                
                if  arr != nil {
                    let  ar = arr?[0] as!  BmobObject
                    ar.setObject(item.iswatched, forKey: "iswatched")
                    
                    
                    ar.setObject(bobuser, forKey: "collectuser")
                    ar.setObject(item.iscollected, forKey: "iscollected")
                    
                    ar.sub_updateInBackground(resultBlock: { (su, err) in
                        result(su,err)
                    })
                    
                }
            })
            
        }
        
    }
    
    
    
    //   获取数据库实时的结果
    func  queryitems(){
        if  isexistuser(){
            let   curuser = LLCurrentUser.currentuser.user
            
            curuser?.userobjid({ (objid) in
                let   bombquery = BmobQuery(className: "LLCategoryRecItem")
                let   query = BmobQuery(className: "_User")
                query?.whereKey("username", equalTo: curuser!.username)
                bombquery?.whereKey("collectuser", equalTo: objid)
                bombquery?.includeKey("collectuser")
                weak   var   tmp = self
                bombquery?.findObjectsInBackground({ (items, err) in
                    var  collectionitems:[LLCollectItem]  = [LLCollectItem]()
                    var  watched:[LLCollectItem]  = [LLCollectItem]()
                    if   err == nil && (items?.count)! > 0 {
                        
                        for   item  in items! {
                            
                            let  newitem = LLCollectItem.itemwithobj(item as! BmobObject)
                            
                            
                            
                            if   newitem.iswatched {
                                watched.append(newitem)
                                
                                
                            }
                            if  newitem.iscollected {
                                
                                collectionitems.append(newitem)
                            }
                        }
                        tmp?.collectionitems = collectionitems
                        tmp?.watcheditems = watched
                        
                        print(watched.count)
                        print(collectionitems.count)
                    }
                    
                    
                    
                })
                
            })
            
        }
        
        
    }
    // 移除收藏
    func    delete(_ item:LLCategoryRecItem,_  result:@escaping  BmobBooleanResultBlock){
        
        if  isexistuser()&&item.collectuser != nil {
            
            
            for   aitem in  self.collectionitems{
                //确保删除的是同一条记录
                if  aitem.item_title == item.item_title && aitem.collectuser.objectId == item.collectuser.objectId   {
                    
                    let   bmobquery = BmobQuery(className: "LLCategoryRecItem")
                    
                    weak  var  tmp  = self
                    
                    bmobquery?.getObjectInBackground(withId: aitem.objectId, block: { (obj, err) in
                        
                    
                        
                        
                        if  err == nil {
                            
                            //查看该项是否被浏览过 如果被浏览过 就别删除
                            let   iswatched = obj?.object(forKey: "iswatched") as?  Bool
                            
                            if  iswatched == true{
                                
                                tmp?.updateitem(item, { (su ,err ) in
                                    tmp?.queryitems()
                                    result(su,err)
                                    
                                })
                                
                                
                            }else{
                            
                            
                            obj?.deleteInBackground({ (su, err) in
                                tmp?.queryitems()
                                result(su,err)
                               
                                
                            })
                            }
                            
                            
                        }
                        
                        
                        
                    })
                    
                    
                    
                }
                
                
                
            }
            
        }
        else{
            let   nserr = NSError(domain: "收藏列表数据错误", code: 404, userInfo: ["issue":"删除代码写的问题"])
            result(false,nserr)
        }
        
    }
  
    
    
    
    
    
    
    
}
