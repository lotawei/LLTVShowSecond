//
//  LLAccoutCell.swift
//  LLTVShow
//
//  Created by lotawei on 17/3/13.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit


class LLAccoutCell: UITableViewCell {
    
    
    @IBOutlet weak var imgicon: UIImageView!
    @IBOutlet weak var lblinfo: UILabel!
    @IBOutlet weak var swtchange: UISwitch!
    @IBOutlet weak var btnarrow: UIButton!
    
    //  调用 .model 会调用此方法   message  icon  info
    var   model:[String:String]? = [:] {
        willSet{
        
            setNeedsLayout()
            
            
            
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        selectionStyle = .none
        
        
        
      
        // 统一管理模式的效果
        
        swtchange.addTarget(self, action: #selector( LLAccoutCell.postchange(_:)), for: .valueChanged)
        if LLCurrentUser.currentuser.user == nil {
             swtchange.isOn  = false
        }
        else{
        if  LLCurrentUser.currentuser.user.substyle == Substyle.dark{
        
                swtchange.isOn  = true
        }
        else{
            swtchange.isOn  = false

        }
        }
        
        
    }
    @objc private func postchange( _ slide:UISwitch){
        
        if  LLCurrentUser.currentuser.user != nil {
        
        if slide.isOn{
            
            let anotificationName = Notification.Name(rawValue: notificationName)
            NotificationCenter.default.post(name: anotificationName, object: LLPOSDarkStyle,
                                            userInfo:nil)
            
        }
        else{
            let anotificationName = Notification.Name(rawValue: notificationName)
            NotificationCenter.default.post(name: anotificationName, object: LLPOSLightStyle,
                                            userInfo:nil)

        }
        
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //  设置 
        if    self.model != nil{
            //  lab 的效果
            self.lblinfo.text   =  model!["info"]
            
            
            //  图标
            self.imgicon.image = UIImage(named:(model!["icon"] )!)
            
            // 右箭头的显示
            let   rightset = model!["isdefault"]
            if   rightset == "default"{
                btnarrow.isHidden = false
                swtchange.isHidden = true
            }else{
                
                
                btnarrow.isHidden = true
                swtchange.isHidden = false
            }
            
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}




