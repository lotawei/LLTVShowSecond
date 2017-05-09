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
        
    
        updatetheme()
        NOTIfyCenter.addObserver(self, selector: #selector(LLBaseButton.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func   updatetheme(){
        if  LLCurrentUser.currentuser.user != nil {
            
            
            
            if LLCurrentUser.currentuser.user.substyle.rawValue == 0 {
                backgroundColor = fontcolor
                 setTitleColor(UIColor.white, for: .normal)
            }
            else if   LLCurrentUser.currentuser.user.substyle.rawValue == 1 {
                backgroundColor = darkcolor
                setTitleColor(UIColor.white, for: .normal)
                
            }
            else if LLCurrentUser.currentuser.user.substyle.rawValue == 2  {
                backgroundColor = eyecolor
                
                 setTitleColor(UIColor.gray, for: .normal)
                
                
            }
            
        }
        else{
            
            backgroundColor = fontcolor
            setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func  basegetnotify(_ notify:Notification){
        updatetheme()
    }
    
    deinit {
          NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
    }

    
    

}
