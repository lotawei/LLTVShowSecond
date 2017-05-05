//
//  LLPrivateInfoViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLPrivateInfoViewController: BaseViewController {
    
   lazy  var  lblname:LLBaseLable = {
        let   lbl  = LLBaseLable()
    lbl.text = "昵称"
//    lbl.textColor = fontcolor
    lbl.font = UIFont.systemFont(ofSize: 12)
    lbl.textAlignment = .left
    
      return  lbl
        
    }()
    
    
    lazy  var  name:LLBaseLable = {
        let   lbl  = LLBaseLable()
        
//        lbl.textColor = fontcolor
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        
        return  lbl
        
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = tablelightcolor
        name.text = LLCurrentUser.currentuser.user.username
        
        
        titleView.text = "个人资料"
        navigationController?.navigationBar.isHidden = false
        view.addSubview(self.lblname)
        view.addSubview(self.name)
        lblname.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.left.equalTo(view).offset(100)
            maker.top.equalTo(view).offset(30)
            
        }
        name.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.centerX.equalTo(view)
            maker.top.equalTo(view).offset(30)
            
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
