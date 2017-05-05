//
//  LLBaseLable.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/4.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLBaseLable: UILabel {
 
    override  init(frame:CGRect){
        super.init(frame: frame)
        NOTIfyCenter.addObserver(self, selector: #selector(LLBaseLable.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        updatecolor()
        
    }
    func  updatecolor(){
        if  LLCurrentUser.currentuser.user != nil {
            
            if   LLCurrentUser.currentuser.user.substyle.rawValue == 0 {
                self.textColor  = fontcolor
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 1{
                self.textColor  = UIColor.black
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 1{
                self.textColor  = eyetextcolor
            }
            
        }
        
   
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func  basegetnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
            
        case LLPOSDarkStyle:
            UIView.animate(withDuration: 0.5, animations:{
              
                self.alpha = 0
                self.alpha = 1
                self.textColor  = UIColor.black
                
            })
            
         
           
            break;
        case LLPOSLightStyle:
            UIView.animate(withDuration: 0.5, animations:{
                self.alpha = 0
                self.alpha = 1
                self.textColor  = fontcolor
               
                
            })
         
            
            break;
        case  LLPOSEyeStyle:
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0
                self.alpha = 1
               self.textColor  =  eyetextcolor
            })
         
            
            break;
        default:
            break;
        }
   
        
    }

    deinit {
            NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }
    

}
