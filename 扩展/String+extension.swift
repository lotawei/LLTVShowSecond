//
//  String+extension.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/13.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import Foundation
extension String {
    func StringToFloat()->(CGFloat){
        
        
        let string = self
        
        var cgFloat: CGFloat = 0
        
        
        
        
        if let doubleValue = Double(string)
            
        {
            
            cgFloat = CGFloat(doubleValue)
            
        }
        
        return cgFloat
        
    }
    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {
        
        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSMakeRange(offset, 1)) as NSString
            if s.isEqual(to: "0") || s.isEqual(to: ".") {
                offset-=1
            } else {
                break
            }
        }
        
        return newStr.substring(to: offset + 1)
    }
    
    //md5
    static  func MD5(str:String) -> String {
        let cString = str.cString(using: .utf8)
        let length = CUnsignedInt(
            str.lengthOfBytes(using:.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(
            capacity: Int(CC_MD5_DIGEST_LENGTH)
        )
        
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
    }
    
    // 转为kb g mb 
    static func transformedValue(_ value:AnyObject) -> String {
    var    multiplyFactor = 0
    var convertedValue = value.doubleValue
        
        let   tokens = ["字节","KB","MB"]
        while (convertedValue! > Double(1024.0)){
        
//            convertedValue /=  Double(1024.0)
            convertedValue  =  convertedValue!  / Double(1024)
        
            multiplyFactor += 1
            
            }
        return "\(String.init(format:"%0.2f",convertedValue!))\(tokens[multiplyFactor])"
    }

    static    func stringWithTimelineDate(_ data:Date) -> String{
        let   formatteryesterday = DateFormatter()
        let   formattersameyear = DateFormatter()
        let   formatterfulldate = DateFormatter()
        formatteryesterday.dateFormat = "昨天 HH:mm"
        formatteryesterday.locale  = NSLocale.current
        
        formattersameyear.dateFormat = "M-d HH:mm"
        formattersameyear.locale = NSLocale.current
        
        formatterfulldate.dateFormat = "yy-M-dd HH:mm"
        formatterfulldate.locale = NSLocale.current
        let  now = Date()
        let delta = now.timeIntervalSince1970 - data.timeIntervalSince1970
        if (delta < -60 * 10) { // 本地时间有问题
            return formatterfulldate.string(from: data)
        } else if (delta < 60 * 10) { // 10分钟内
            return "刚刚"
        } else if (delta < 60 * 60) { // 1小时内
            return  "\(String.init(format:"%0.f",delta/60))"+"分钟前"
        }
        return   formatterfulldate.string(from: data)
        
        
        
    }
    //
   static func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
    
        let statusLabelText: NSString = labelStr as NSString
        
       let size = CGSize(width:width, height:900)
        
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
    
        return strSize.height
        
    }
    
}


extension UITextField{

    func validate(value: String) -> Bool{
        let  whitespace = NSCharacterSet.whitespaces
        let predicate = NSPredicate(format: " SELF MATCHES %@" , value)
        
        return predicate.evaluate(with: self.text?.trimmingCharacters(in: whitespace))
        
    }
    
    
    func validateEmail() -> Bool{
        
        
        return self.validate( value: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9,-]+\\.[A-Za-z]{2,6}")
        
    }
    
    
    func validatePhoneNumer() -> Bool{
        
        return self.validate(value:"^\\d{11}$")
        
    }
    
    
    func validatePassword() -> Bool {
        
        return self.validate(value: "^[A-Z0-9a-z]{6,18}")
        
    }
    
    
    
 
}



