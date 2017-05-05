//
//  LLMainTabarController.swift
//  LLTVShow
//
//  Created by lotawei on 17/1/11.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLMainTabarController: LLAnimationTabBarController,UITabBarControllerDelegate {
    
    var  bouceanimation = RAMBounceAnimation()
  fileprivate  var  isfirstLoadMaintabarcontroller : Bool =   true
    override func viewDidLoad() {
     NOTIfyCenter.addObserver(self, selector: #selector(LLMainTabarController.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
        delegate = self
        buildMainTabarChildViewController()
    }
    func buildMainTabarChildViewController()  {
        
        tabBarControllerAddChildViewController(LLTVListViewController() , title: "影视", imagename: "Mytv_normal", selectimagename: "Mytv_select", tag: 0)
        tabBarControllerAddChildViewController(LLAcountViewController() , title: "我的", imagename: "MyAcount_normal", selectimagename: "MyAcount_select", tag: 1)
       
        
        selectedIndex = 0 
    }
    override  func viewDidAppear(_ animated: Bool) {
        
        if isfirstLoadMaintabarcontroller {
            let   containers = createViewContainers()
            createCustomIcons(containers)
            isfirstLoadMaintabarcontroller = false
        }
    }
    
    
    func  basegetnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
            
        case LLPOSDarkStyle:
           
            curcolor()
            
            break;
        case LLPOSLightStyle:
            curcolor()
            
            
            break;
        case  LLPOSEyeStyle:
          
            curcolor()
            
            break;
        default:
            break;
        }
        
        
    }
    deinit {
            NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
        }
    
    func  curcolor()->UIColor{
        
          
        
        if  LLCurrentUser.currentuser.user != nil {
            
            if   LLCurrentUser.currentuser.user.substyle.rawValue == 0 {
               return fontcolor
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 1{
                return  UIColor.black
            }
            else if  LLCurrentUser.currentuser.user.substyle.rawValue == 1{
                return   UIColor.blue
            }
            
        }
        return  fontcolor
        
        
    }
    
}
extension   LLMainTabarController{
    func tabBarControllerAddChildViewController(_ childView: UIViewController, title: String, imagename: String, selectimagename: String, tag: Int)
    {
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imagename), selectedImage: UIImage(named: selectimagename))
        vcItem.tag = tag
        /**
         *  设置            动画效果
         
         *
         *  @param rootViewController:childView
         *
         *  @return   有旋转  弹跳  翻转
         */
        
      
        
        bouceanimation.textSelectedColor  = curcolor()
        vcItem.animation = bouceanimation
        
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNaVgationController(rootViewController:childView)
        addChildViewController(navigationVC)
    }
}


