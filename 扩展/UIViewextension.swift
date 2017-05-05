//
//  UIViewextension.swift
//  LLTVShow
//
//  Created by lotawei on 16/11/27.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit



extension  UIView{
    var x : CGFloat {
        get {
            return frame.origin.x
        }
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    // y
    var y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y  = newVal
            frame = tmpFrame
        }
    }
    
    // height
    var height : CGFloat {
        
        get {
            
            return frame.size.height
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    // width
    var width : CGFloat {
        
        get {
            
            return frame.size.width
        }
        
        set(newVal) {
            
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    // left
    var left : CGFloat {
        
        get {
            
            return x
        }
        
        set(newVal) {
            
            x = newVal
        }
    }
    
    // right
    var right : CGFloat {
        
        get {
            
            return x + width
        }
        
        set(newVal) {
            
            x = newVal - width
        }
    }
    
    // top
    var top : CGFloat {
        
        get {
            
            return y
        }
        
        set(newVal) {
            
            y = newVal
        }
    }
    
    // bottom
    var bottom : CGFloat {
        
        get {
            
            return y + height
        }
        
        set(newVal) {
            
            y = newVal - height
        }
    }
    
    var centerX : CGFloat {
        
        get {
            
            return center.x
        }
        
        set(newVal) {
            
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    var centerY : CGFloat {
        
        get {
            
            return center.y
        }
        
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    var middleX : CGFloat {
        
        get {
            
            return width / 2
        }
    }
    
    var middleY : CGFloat {
        
        get {
            
            return height / 2
        }
    }
    
    var middlePoint : CGPoint {
        
        get {
            
            return CGPoint(x: middleX, y: middleY)
        }
    }
    //为其创建渐变色

    
    func gradient(_ start:UIColor , endcolor:UIColor)  {
         var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
         gradientLayer.locations = [0.0,0.6,1.0]
        //设置渐变的主颜色
        gradientLayer.colors = [start.cgColor, endcolor.cgColor]
        //将gradientLayer作为子layer添加到主layer上
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func cubeAnimate() {
        let virtualTargetView = self
        // 复制UIView，作为底面
        let viewCopy = UIImageView(frame: virtualTargetView.frame)
        viewCopy.alpha = 0
        viewCopy.backgroundColor = UIColor.clear
        // 设置底面UIView的初始位置和高度
        viewCopy.transform = CGAffineTransform(scaleX: 0.5, y: 0.1).concatenating(CGAffineTransform(translationX: 1.0, y: viewCopy.frame.height / 2))
        self.addSubview(viewCopy)
        UIView.animate(withDuration: 0.5, animations: {
            // 执行UIView和UIViewCopy的动画
            virtualTargetView.transform = CGAffineTransform(scaleX: 0.2, y: 0.1).concatenating(CGAffineTransform(translationX: ScreenWidth - 10, y: ScreenHeight - kTabBarH))
            virtualTargetView.alpha = 0
            viewCopy.alpha = 1
           
        }, completion: { _ in
            // 当动画执行完毕后，将UIViewCopy的信息赋值给UIView，并还原UIView的状态，即与UIViewCopy相同的状态，然后移除UIViewCopy
            virtualTargetView.alpha = 1
           
            
            viewCopy.removeFromSuperview()
            self.removeFromSuperview()
        })
    
    }
    
    

}
