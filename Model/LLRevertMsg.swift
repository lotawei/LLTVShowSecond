//
//  LLRevertMsg.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/16.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLRevertMsg: BmobObject {
    
    var    username:String = ""
    var    content:String! = ""
    var     phonenumber:String = ""
    var  usertype:NSNumber = 0
    
    
    typealias RevertBlock = (_ msgs:[LLRevertLayout]?) -> Void
    
    static   func   msgwithobj(_ obj:BmobObject) -> LLRevertMsg{
        let   msg =  LLRevertMsg(className: "FeedBack")
        msg?.username = obj.object(forKey: "username") as! String
        msg?.content =  obj.object(forKey: "content") as! String
        msg?.phonenumber =  obj.object(forKey: "phonenumber") as! String
        
        msg?.objectId = obj.objectId
             msg?.createdAt = obj.createdAt
             msg?.updatedAt = obj.updatedAt
        return   msg!
    }
    //  一个发表
    static   func   pubrevert(_ name:String!,_ content:String!, _ number:String,_ result:@escaping BmobBooleanResultBlock){
        
         let   msg = LLRevertMsg(className: "FeedBack")
         msg?.setObject(name, forKey: "username")
         msg?.setObject(content, forKey: "content")
         msg?.setObject(0, forKey: "usertype")
         msg?.setObject(number, forKey: "phonenumber")
//         msg?.sub_saveInBackground(resultBlock: { (success, err) in
//            result(success, err)
//         })
        msg?.saveInBackground(resultBlock: { (success, err) in
            result(success, err)

        })
        
    }
    
    
    
    //  一个查询
      static   func   getallrevertmsgs(_ result:@escaping RevertBlock) {
        let    bmobquery = BmobQuery(className: "FeedBack")
        bmobquery?.order(byDescending: "createdAt")
        bmobquery?.findObjectsInBackground({ (msgs, err) in
            if   err != nil {
                
                result(nil)
                
            }
            else{
                
                var  newmsgs = [LLRevertLayout]()
                
                for   obj in msgs!{
                    
                    let msg = obj as!  BmobObject
                    let  amsg  =   LLRevertMsg.msgwithobj(msg)
                    
                    let  lay = LLRevertLayout.init(amsg)
                    
                    newmsgs.append(lay)
                    
                    
                    
                }
                
                result(newmsgs)
                
            }
            
            
            
        })
        
        
        
        
    }


}
