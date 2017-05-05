//
//  LLBaseButton.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/4.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLBaseButton: UIButton {
    override  init(frame:CGRect){
        super.init(frame: frame)
        
        if  LLCurrentUser.currentuser.user != nil {
            
            setTitleColor(LLCurrentUser.currentuser.user.substyle.substylecolor(), for: .normal)
            
            if LLCurrentUser.currentuser.user.substyle.rawValue == 0 {
                backgroundColor = fontcolor
            }
            else if   LLCurrentUser.currentuser.user.substyle.rawValue == 1 {
                backgroundColor = darkcolor
          
            }
            else if LLCurrentUser.currentuser.user.substyle.rawValue == 2  {
                backgroundColor = UIColor.gray
            }
            
        }
        
        NOTIfyCenter.addObserver(self, selector: #selector(LLBaseButton.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func  basegetnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
            
        case LLPOSDarkStyle:
        
                
                
            setTitleColor(UIColor.white, for: .normal)
          
            backgroundColor = darkcolor
            
            
            break;
        case LLPOSLightStyle:
             setTitleColor(fontcolor, for: .normal)
            
             backgroundColor = fontcolor
            break;
        case  LLPOSEyeStyle:
             setTitleColor(eyecolor, for: .normal)
              backgroundColor = UIColor.gray
            
            break;
        default:
            break;
        }
        
    }
    
    deinit {
          NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }

    
    

}
