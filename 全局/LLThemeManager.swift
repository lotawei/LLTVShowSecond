

//
//  LLThemeManager.swift
//  LLTVShow
//
//  Created by lotawei on 17/3/8.
//  Copyright © 2017年 lotawei. All rights reserved.
//
// 主要管理的主题的类 单例
import UIKit

//   改变颜色 主要是 1.  字体颜色 2. 背景颜色
@objc  protocol  Themechangepro:NSObjectProtocol{
    
    //字体颜色
    func  textcolror()-> UIColor
    //背景颜色
    func   bakcgroundcolor()-> UIColor
    //背景图片
    func   bakcgroudimage ()-> UIImage

    
}




class LLThemeManager: NSObject {
    
    
    
     override  init(){
        super.init()
    }
    
    
    
    
    
    
    
}
