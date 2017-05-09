//
//  LLBaseTableView.swift
//  LLTVShow
//
//  Created by lotawei on 17/2/9.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLBaseTableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        delaysContentTouches = false
        canCancelContentTouches = true
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView") {
            
            for gesture in wrapView!.gestureRecognizers! {
                if (NSStringFromClass(gesture.classForCoder).contains("DelayedTouchesBegan")) {
                    gesture.isEnabled = false
                    break
                }
            }
        }
     
        
        NOTIfyCenter.addObserver(self, selector: #selector(LLBaseTableView.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
    
        
        
    }
    func   updatetheme(){
        if  LLCurrentUser.currentuser.user != nil {
            if LLCurrentUser.currentuser.user.substyle == Substyle.dark{
                
                backgroundColor = tablebackcolor
            }
            else if LLCurrentUser.currentuser.user.substyle == Substyle.normal {
                
                backgroundColor = tablelightcolor
                
            }
            else{
                  backgroundColor = tableeyecolor
            }
        }
        else{
            
              backgroundColor = tablelightcolor
        }
        
    }
    
    func  basegetnotify(_ notify:Notification){
        updatetheme()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIControl.self) {
            return true
        }
        
        return super.touchesShouldCancel(in: view)
    }
    deinit {
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
       
        print("base释放")
        
        
    }

}
