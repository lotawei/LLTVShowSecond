//
//  LLThemeViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/4.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLThemeViewController: BaseViewController {
    
  lazy  var   scorllerview:UIScrollView = {
       let scorllerview = UIScrollView()
        scorllerview.showsVerticalScrollIndicator = false
        scorllerview.showsHorizontalScrollIndicator = false
        return  scorllerview
    }()
   
    var    seletedstyle:Int = 0
    
    var    stylebtns:[UIButton] = [UIButton]()
    
    
    var   datas:[( img:UIImage, name:String)] = [(UIImage(named: "img_light")!,LLPOSLightStyle),(UIImage(named: "img_dark")!,LLPOSDarkStyle),(UIImage(named: "img_eyepro")!,LLPOSEyeStyle)]
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      NOTIfyCenter.addObserver(self, selector: #selector(LLBaseLable.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
      
     
        navigationController?.navigationBar.isHidden = false
        
        
        
        view.addSubview(self.scorllerview)
        scorllerview.snp.makeConstraints {
            $0.height.equalTo(view)
            $0.width.equalTo(view)
            $0.centerX.equalTo(view)
            $0.top.equalTo(view).offset(10)
            
            
        }
        
        var  i = 0
        for  (img,str) in datas{
            
            let  btn = LLBaseButton()
            btn.tag = i
            btn.setTitle(str, for: .normal)
            btn.titleLabel?.tintColor = fontcolor
            btn.showsTouchWhenHighlighted = true
            btn.setTitleColor(fontcolor, for: .normal)
            btn.setBackgroundImage(img, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.gray.cgColor
            btn.addTarget(self, action: #selector(changesub(_:)), for: .touchUpInside)
            scorllerview.addSubview(btn)
            
            i = i + 1
            stylebtns.append(btn)
        }
        layoutbtns()
        seletedstyle  = LLCurrentUser.currentuser.user.substyle.rawValue
        
        titleView.text = stylebtns[seletedstyle].titleLabel?.text
        
               // Do any additional setup after loading the view.
    }
    
    func  changesub(_ sender:UIButton){
        //  暂时不先同步按钮的选中
        
        // 
        if  !sender.isSelected {
        let anotificationName = Notification.Name(rawValue: notificationName)
        NotificationCenter.default.post(name: anotificationName, object: sender.titleLabel?.text,
                                        userInfo:nil)
        
            selectitem(sender.tag)
        }
        
    }
    func layoutbtns(){
        scorllerview.contentSize = CGSize(width: ScreenWidth * CGFloat(datas.count),height:0)

        let btnwidth:CGFloat = 150
        let  paddx:CGFloat = 10
        var  huawidth:CGFloat = 0
        for  i in 0..<datas.count{
            let  btn =  stylebtns[i]
            let  x = CGFloat(i) * btnwidth + CGFloat(i)*paddx
            btn.snp.makeConstraints({
                $0.width.equalTo(btnwidth)
                $0.height.equalTo(200)
                $0.left.equalTo(scorllerview).offset(x)
                $0.top.equalTo(scorllerview)
            })
            huawidth = x + btnwidth + paddx
        }
        scorllerview.contentSize = CGSize(width:  huawidth, height: 0)
        
    }
    func  selectitem(_ item:Int){
        
        
        
        for   btn in stylebtns {
       
            btn.isSelected = false
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.white.cgColor
            let  selectselecbtn = stylebtns[item]
            
            selectselecbtn.isSelected = true
            selectselecbtn.layer.borderColor = UIColor.gray.cgColor
            selectselecbtn.layer.borderWidth = 1
            seletedstyle = selectselecbtn.tag
            titleView.text = stylebtns[seletedstyle].titleLabel?.text
            
        }
     
        
       
        
    }
    

}
