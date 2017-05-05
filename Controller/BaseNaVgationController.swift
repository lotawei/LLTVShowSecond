//
//  BaseNaVgationController.swift
//  LLTVShow
//
//  Created by lotawei on 16/11/27.
//  Copyright © 2016年 lotawei. All rights reserved.
//)

import UIKit

//class BaseNaVgationController:UINavigationController,UIGestureRecognizerDelegate {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //设置右划手势的代理为自己
//        self.interactivePopGestureRecognizer?.delegate = self
//    }
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        //设置右划返回为true
//        self.interactivePopGestureRecognizer?.isEnabled = true
//    }
//}


class BaseNaVgationController: UINavigationController {
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
         NOTIfyCenter.addObserver(self, selector: #selector(BaseNaVgationController.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
    
        
        
    }
    
    func setNaviBack(){
        let  navigationBar = UINavigationBar.appearance()
     
        
        if  LLCurrentUser.currentuser.user != nil {
            if  LLCurrentUser.currentuser.user.substyle.rawValue == 0 {
                 navigationBar.backgroundColor = normalcolor
                 navigationBar.barTintColor = fontcolor
                navigationBar.setBackgroundImage(UIImage(named:"img_light"), for: .default)
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 1 {
                navigationBar.backgroundColor = darkcolor
                navigationBar.barTintColor = UIColor.black
                navigationBar.setBackgroundImage(UIImage(named:"img_dark"), for: .default)
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 2 {
                navigationBar.backgroundColor = eyecolor
                navigationBar.barTintColor = eyecolor
                navigationBar.setBackgroundImage(UIImage(named:"img_eyepro"), for: .default)
            }
            
            
        }
        else{
            navigationBar.backgroundColor = normalcolor
            navigationBar.barTintColor = fontcolor
            navigationBar.setBackgroundImage(UIImage(named:"img_light"), for: .default)
        }
       
       
    //返回按钮的箭头颜色
        //字体颜色
        navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:fontcolor]
        
        
        
    }
    
      //这里可以更导航条颜色
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNaviBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  basegetnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
            
        case LLPOSDarkStyle:
            
             setNaviBack()
            break;
        case LLPOSLightStyle:
              setNaviBack()
            break;
        case  LLPOSEyeStyle:
               setNaviBack()
                    break;
        default:
            break;
        }
    }

    deinit {
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
        
    }
    
}
