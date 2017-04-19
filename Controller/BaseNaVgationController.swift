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
        
       //初始化nav
        
        setNaviBack()
        
        
        
        
    }
    
    func setNaviBack(){
    
        
  
    let  navigationBar = UINavigationBar.appearance()
    //去掉线
    navigationBar.backgroundColor = normalcolor
    
    navigationBar.tintColor = fontcolor
    //返回按钮的箭头颜色
        //字体颜色
        navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:fontcolor]
      
    }
 
    
    //这里可以更导航条颜色
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.setBackgroundImage(imagewithcolor(color: normalcolor), for: .default)
        navigationBar.shadowImage = UIImage()

        
        
    }
    
   
    
    // 半透明背景
    func imagewithcolor(color:UIColor) -> UIImage {
        let  rect =  CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        //上下文
        UIGraphicsBeginImageContext(rect.size)
        
        let   context  = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        //从上下文获取图片
        let   theimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        return   theimage!
    }
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
