//
//  UIViewController+extension.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/30.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
extension BaseNaVgationController {
    func viewDidLoadForChangeTitleColor() {
        self.viewDidLoadForChangeTitleColor()
        if self.isKind(of: UINavigationController.classForCoder()) {
            self.changeNavigationBarTextColor(navController: self as  UINavigationController)
        }
    }
    
    func changeNavigationBarTextColor(navController: UINavigationController) {
        let nav = navController as UINavigationController
        let dic = NSDictionary(object: UIColor.applicationMainColor(),
                               forKey:NSForegroundColorAttributeName as NSCopying)
        nav.navigationBar.titleTextAttributes = dic as? [String : Any]
        nav.navigationBar.barTintColor = UIColor.applicationSecondColor()
        nav.navigationBar.tintColor = UIColor.applicationMainColor()
        
    }
    
}
