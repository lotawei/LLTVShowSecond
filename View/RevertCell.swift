//
//  RevertCell.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/16.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
let  toppading:CGFloat  = 15
let  txtfont:CGFloat  = 16
//img   30  30   名称  200  20   时间   200 20  红色字体  宽度  下方 电话高度30
//toppadding  15 文本 内容  字体 18
class  LLRevertLayout {
 
    var   revertmsg:LLRevertMsg!
    //  手动计算
    
    var   cellheight:CGFloat = 0
    
    var    imageheight:CGFloat = 30
    
    
    var    textheight:CGFloat = 0
    
    
    var    phoneheight:CGFloat = 40
    
    convenience init(_ msg:LLRevertMsg) {
        self.init()
        revertmsg = msg
        layoutheight()
        
    }
    func layoutheight(){
        
        
        cellheight =  cellheight + toppading
        
        cellheight =  cellheight + imageheight
        
        cellheight =  cellheight + toppading
        layouttextviewheight()
        if   revertmsg.phonenumber != "无" && revertmsg.phonenumber.characters.count > 0 {
          cellheight =  cellheight + phoneheight
        
       
        }
        
        cellheight = cellheight + toppading
      
    }
    func  layouttextviewheight(){
        
        let  text = revertmsg.content
        let   atextheight = String.getLabHeigh(labelStr: text!, font: UIFont.systemFont(ofSize: txtfont), width: ScreenWidth - 2*toppading)
        textheight = atextheight
        cellheight =  cellheight + atextheight
        
    }
    
    
    
    
}



class RevertCell: UITableViewCell {
    
    var   revertlay:LLRevertLayout!
    
    lazy   var   imgusertype:UIImageView = {
        
       let  imgview = UIImageView()
        imgview.image = UIImage(named: "default")
        
        return imgview
        
    }()
    lazy  var   lblusername:LLBaseLable!   = {
        
        let  lab = LLBaseLable()
        
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .left
        lab.textColor = UIColor.gray
        
        return  lab
        
    }()
    lazy  var   lbltime:LLBaseLable!   = {
        
        let  lab = LLBaseLable()
        
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textAlignment = .left
        lab.textColor = UIColor.gray
        
        return  lab
        
    }()
   
    
    lazy   var   textview:LLBaseLable = {
        
        
        
        let  lab = LLBaseLable()
        lab.font = UIFont.systemFont(ofSize: txtfont)
        lab.textAlignment = .left
        lab.textColor = UIColor.black
        
        lab.numberOfLines = 0
        return  lab
    }()
    
    lazy   var   lblphone:UILabel = {
        let  lab = UILabel()
        lab.frame = CGRect.zero
        lab.font = UIFont.systemFont(ofSize: 14)
        
        lab.text = "联系方式:"
        lab.textAlignment = .right
        lab.textColor = UIColor.gray
        
     
        return  lab
    }()
    
    lazy   var   btnphone:UIButton  = {
        let  btnphone  = UIButton.init(type: .custom)
        btnphone.showsTouchWhenHighlighted = true
        btnphone.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnphone.backgroundColor = UIColor.black
        btnphone.tintColor = UIColor.white
        btnphone.layer.cornerRadius  = 20
        
        return  btnphone
        
    }()
//    lazy   var   baselineview:UIView = {
//        
//        let   aview = UIView()
//        aview.backgroundColor = UIColor.init(colorLiteralRed: 149.0/255.0, green: 149.0/255.0, blue: 149.0/255.0, alpha: 1.0)
//        
//        
//        return aview
//        
//    }()
//    
    
    
    
    
    func  contact(){
        
        
        
    }
    
    
    
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.backgroundColor = tablelightcolor
        contentView.autoresizesSubviews = false
        contentView.addSubview(imgusertype)
        contentView.addSubview(lblusername)
        contentView.addSubview(lbltime)
        contentView.addSubview(textview)
        contentView.addSubview(btnphone)
        contentView.addSubview(lblphone)
//        contentView.addSubview(baselineview)
    
    }
    
    
    func  setrevert(_ layout:LLRevertLayout){
        lblphone.isHidden = false
        btnphone.isHidden = false
        revertlay = layout
        self.height = layout.cellheight
        lblusername.text =  layout.revertmsg.username
        lbltime.text =  String.stringWithTimelineDate(layout.revertmsg.createdAt)
        textview.text  = layout.revertmsg.content
        if   layout.revertmsg.phonenumber != "无"{
            
          
            
            btnphone.setTitle(layout.revertmsg.phonenumber, for: .normal)
            btnphone.addTarget(self, action: #selector(RevertCell.contact), for: .touchUpInside)
            btnphone.snp.makeConstraints({ (maker) in
                maker.height.equalTo(revertlay.phoneheight)
                maker.width.equalTo(120)
                maker.top.equalTo(revertlay.cellheight - 10 - revertlay.phoneheight)
                maker.left.equalTo(ScreenWidth - toppading - 120 )
            })
            lblphone.snp.makeConstraints { (maker) in
                maker.height.equalTo(revertlay.phoneheight)
                maker.width.equalTo(80)
                maker.top.equalTo(revertlay.cellheight - 10 - revertlay.phoneheight)
                maker.left.equalTo(ScreenWidth - 80 - 2 * toppading  - 120 )
                
            }
        }
        else{
             lblphone.isHidden = true
            btnphone.isHidden = true

            
        }
//        baselineview.snp.makeConstraints({ (maker) in
//        
//        maker.height.equalTo(1)
//        maker.width.equalTo(ScreenWidth)
//        maker.top.equalTo(self.height - 1)
//        maker.left.equalTo(0)
//        
//        
//        })//        setNeedsLayout()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgusertype.snp.makeConstraints { (maker) in
            maker.height.equalTo(30)
            maker.width.equalTo(30)
            maker.top.equalTo(toppading)
            maker.left.equalTo(toppading)
            
        }
        lblusername.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.width.equalTo(250)
            maker.top.equalTo(toppading)
            maker.left.equalTo(60)
            
        }
        lbltime.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.width.equalTo(250)
            maker.top.equalTo(toppading + 20)
            maker.left.equalTo(60)
            
        }
      
        
        textview.snp.makeConstraints { (maker) in
            maker.height.equalTo(revertlay.textheight)
            maker.width.equalTo(ScreenWidth - 2*toppading)
            maker.top.equalTo(70)
            maker.left.equalTo(toppading)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
}
