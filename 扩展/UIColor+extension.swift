//
//  UIColor+extension.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/13.
//  Copyright © 2016年 lotawei. All rights reserved.
//
import UIKit
extension UIColor {
    convenience public init(rgba: Int64) {
        let red   = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let blue  = CGFloat((rgba & 0x0000FF00) >> 8)  / 255.0
        let alpha = CGFloat( rgba & 0x000000FF)        / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    class func colorWithCustom(_ r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func colorWithHex(_ hex: UInt) -> UIColor {
        let r: CGFloat = CGFloat((hex & 0xff0000) >> 16)
        let g: CGFloat = CGFloat((hex & 0x00ff00) >> 8)
        let b: CGFloat = CGFloat(hex & 0x0000ff)
        
        return rgb(r, green: g, blue: b)
    }
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r, g: g, b: b)
    }
    //主题色
    class func applicationMainColor() -> UIColor {
        return fontcolor
    }
    //第二主题色
    class func applicationSecondColor() -> UIColor {
        return fontcolor
    }
    //警告颜色
    class func applicationWarningColor() -> UIColor {
        return UIColor(red: 0.1, green: 1.0, blue: 0.0, alpha: 1)
    }
    //链接颜色
    class func applicationLinkColor() -> UIColor {
        return UIColor(red: 59.0/255, green: 89.0/255.0, blue: 152.0/255.0, alpha:1)
    }
//半透明
   static func imagewithcolor(color:UIColor) -> UIImage {
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

}
