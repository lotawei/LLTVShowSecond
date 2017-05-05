//
//  LLRevertViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/13.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLRevertViewController: BaseViewController, UITextFieldDelegate,UITextViewDelegate{

    lazy  var  lblphone:LLBaseLable = {
            let  lab = LLBaseLable()
            lab.text  = "联系方式："
            lab.font = UIFont.systemFont(ofSize: 14)
            lab.textAlignment = .left
        
//            lab.textColor = fontcolor
            return  lab
            
       
    }()
    
    
    lazy  var   lblcontent:LLBaseLable = {
        
        let  lab = LLBaseLable()
        lab.text  = "宝贵意见："
        lab.font = UIFont.systemFont(ofSize: 14)
        lab.textAlignment = .left
//        lab.textColor = fontcolor
        return  lab
        
        
    }()
    //联系方式
    lazy  var  txtphone:UITextField = {
        let   field = UITextField()
        
        field.borderStyle = .roundedRect
      
        field.delegate  = self
        return  field
    }()
    
    
   
    lazy  var  txtcontent:UITextView = {
        let   txtview = UITextView()
         txtview.textColor = UIColor.gray
        txtview.text =      "虚心接受你的建议😅"
        txtview.delegate = self
        return  txtview
    }()
    
    lazy  var   lbllimit:UILabel = {
        
        let  lab = LLBaseLable()
        lab.text  = "限制500字"
        lab.font = UIFont.systemFont(ofSize: 10)
        lab.textAlignment = .right
        lab.backgroundColor = normalcolor
        lab.textColor = UIColor.gray
        return  lab
        
        
    }()
    
    //发送
    lazy var btnsend:UIButton = {
        let  revert  = UIButton()
        revert.showsTouchWhenHighlighted = true
        revert.setTitle("提交反馈", for: .normal)
        revert.backgroundColor = fontcolor
        revert.addTarget(self, action: #selector(LLRevertViewController.pubrevert), for: .touchUpInside)
    
        
        return  revert
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        titleView.text = "反馈"
        view.addSubview(lblphone)
        view.addSubview(txtphone)
        view.addSubview(lblcontent)
        
        view.addSubview(txtcontent)
        
        
        view.addSubview(lbllimit)
        view.addSubview(btnsend)
  
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.lblphone.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.width.equalTo(100)
            maker.height.equalTo(30)
            maker.top.equalTo(30)
        }
        self.txtphone.snp.makeConstraints { (maker) in
            maker.left.equalTo(110)
            maker.width.equalTo(250)
            maker.height.equalTo(30)
            maker.top.equalTo(30)
        }
        self.lblcontent.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.width.equalTo(100)
            maker.height.equalTo(30)
            maker.top.equalTo(70)
        }
        self.txtcontent.snp.makeConstraints { (maker) in
            maker.left.equalTo(110)
            maker.width.equalTo(250)
            maker.height.equalTo(300)
            maker.top.equalTo(70)
        }
        self.lbllimit.snp.makeConstraints { (maker) in
            maker.right.equalTo(txtcontent)
            maker.width.equalTo(200)
            maker.height.equalTo(20)
            maker.top.equalTo(370)
        }
        self.btnsend.snp.makeConstraints { (maker) in
            maker.right.equalTo(txtcontent)
            maker.width.equalTo(150)
            maker.height.equalTo(30)
            maker.top.equalTo(390)
        }

    }
    func   pubrevert(){
        
        let  username  = LLCurrentUser.currentuser.user.username
       
        var   number = ""
        if  txtphone.text == nil {
            number = "无"
        }else{
        
          number = (txtphone.text?.characters.count)! > 0 ? txtphone.text! : "无"
        }
        let  content = txtcontent.text != "虚心接受你的建议😅" && txtcontent.text.characters.count > 0 ?  txtcontent.text:""
        if  content == ""{
              _  = SweetAlert().showAlert("意见不能为空！")
            return
        }
        LLRevertMsg.pubrevert(username, content, number) { (s, err) in
            
            if   err == nil &&  s{
                
                _  = SweetAlert().showAlert("反馈成功！")

                
            }
            
            
        }
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if   !txtphone.isExclusiveTouch{
            txtphone.resignFirstResponder()
        }
        if   !txtcontent.isExclusiveTouch{
            txtcontent.resignFirstResponder()
        }
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if   !textField.isExclusiveTouch{
            textField.resignFirstResponder()
        }
        return  true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func textViewDidEndEditing(_ textView: UITextView) {
        if   textView.text.characters.count < 1{
            textView.text =  "虚心接受你的建议😅"
            textView.textColor = UIColor.gray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if   textView.text == "虚心接受你的建议😅"{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
}
