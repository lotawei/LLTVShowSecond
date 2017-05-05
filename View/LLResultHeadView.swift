//
//  LLResultHeadView.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/24.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
@objc protocol SelectCategoriesPro:NSObjectProtocol {
    
    @objc optional func   selectedindex(_ items:[LLCategoryRecItem],categorie:String)
    
    
}


let  sizeheight:CGFloat = 45
let  leftposx:CGFloat = (ScreenWidth / 3.0) * 2.0
let  btnheight:CGFloat = 20
let  leftpadding:CGFloat = 5
let  btnpadding:CGFloat = 10
let  fontsize:CGFloat = 12

class LLResultHeadView: UIView {
    
    weak  var   seletcdelegate:SelectCategoriesPro?
    fileprivate   var   valuekey:String!
    fileprivate    var   searchresult:LLSearchResult!
    fileprivate  var   selectindex = 0
      let  toppadding:CGFloat = ( sizeheight - btnheight )/2.0
     var    keywidth:CGFloat =  0
    var  itemsscrollerview:UIScrollView = {
        let   scrollerview = UIScrollView()
        scrollerview.frame = CGRect(x: leftposx, y: 0, width: ScreenWidth - leftposx - leftpadding, height: sizeheight)
        scrollerview.showsVerticalScrollIndicator = false
        scrollerview.showsHorizontalScrollIndicator = false
        return  scrollerview
        
    }()
    
  
    
   
    
    lazy var   btns:[UIButton] = {
        let   btn =  [UIButton]()
        return  btn
    }()
    
    lazy  var   seletcitem:[LLCategoryRecItem] = {
        let   item = [LLCategoryRecItem]()
        return  item
        
    }()
    
    lazy  var   lab1:LLBaseLable = {
        let   lab1 = LLBaseLable()
       
        lab1.textAlignment = .right
        lab1.font =  UIFont.systemFont(ofSize: fontsize)
        lab1.text = "有关"
        
        return  lab1
        
    }()
    lazy  var   labinfo:LLBaseLable = {
        let   lbl = LLBaseLable()
     
        lbl.textAlignment = .left
        lbl.font =  UIFont.systemFont(ofSize: fontsize)
        
        return  lbl
        
    }()
    
    lazy  var   labcount:LLBaseLable = {
        let   lbl = LLBaseLable()
        lbl.textColor  =  UIColor.gray
        lbl.textAlignment = .left
        lbl.font =  UIFont.systemFont(ofSize: fontsize)
        lbl.text = "0条"
        return  lbl
        
    }()
    
    override  init(frame:CGRect){
        super.init(frame: CGRect(x:0,y:0,width:ScreenWidth,height:sizeheight))
        
        addSubview(itemsscrollerview)

        addSubview(lab1)
        addSubview(labinfo)
        addSubview(labcount)
        backgroundColor = UIColor.init(patternImage: UIImage(named:"background")!)

    }
    convenience  init(frame:CGRect, key:String){
        self.init(frame:frame)
        valuekey = key
        labinfo.text = "\"" + key + "\""
        
        keywidth = String.getLabWidth(labelStr:  labinfo.text!, font:UIFont.systemFont(ofSize:fontsize) , height: btnheight) + 5  >  60 ? String.getLabWidth(labelStr:  labinfo.text!, font:UIFont.systemFont(ofSize:fontsize) , height: btnheight) + 5:60
        
    }
    
    func   setsearchresult(_ searchresult:LLSearchResult!){
        self.searchresult = searchresult
        //labcount.text = "\(searchresult.totalitems)" + "条"
        if   searchresult.categories.count == 0 {
            
            labinfo.text = "无结果"
            lab1.alpha  = 0
            labcount.alpha = 0
            
            
        }
        else{
            
            
            var    x:CGFloat  = 0
            
            var   lastwidth:CGFloat  = 0
            for   i in  0..<searchresult.categories.count{
                
                var   btnwidth:CGFloat  = 0
                
                
                
                let   btn = UIButton()
                btn.tag = 100 + i
                btn.showsTouchWhenHighlighted = true
                btn.setTitle(searchresult.categories[i], for: .normal)
                btn.backgroundColor = UIColor.gray
                btn.addTarget(self, action: #selector(selectedcate(_:)), for: .touchUpInside)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: fontsize)
                btn.titleLabel?.textColor = UIColor.green
                btn.setBackgroundImage(UIImage(named:"normal"), for: .normal)
                btn.setBackgroundImage(UIImage(named:"select"), for: .selected)
                //计算
                let   str = searchresult.categories[i]
                btnwidth = String.getLabWidth(labelStr: str, font: UIFont.systemFont(ofSize: fontsize), height: btnheight) + 2
                x = x + lastwidth + btnpadding
                
                btn.frame = CGRect(x: x, y: toppadding, width: btnwidth, height: btnheight)
                lastwidth =  btnwidth
                if  i==0 {
                    btn.isSelected = true
                    
                    searchitem(searchresult.categories[i])
                     seletcdelegate?.selectedindex!(seletcitem, categorie: searchresult.categories[i])
                    
                }else{
                    btn.isSelected = false
                }
                btns.append(btn)
                itemsscrollerview.addSubview(btn)
            }
            laycontensize()
            
        }
        
        
    }
    private   func  laycontensize(){
        let  pads = CGFloat( btns.count - 1) * btnpadding
        var  allwidth:CGFloat = 0
        for  btn in btns{
            let   width  = btn.width
            
            allwidth = allwidth + width
            
        }
        let   wid = allwidth + pads  + 2*btnpadding
         itemsscrollerview.contentSize  = CGSize(width: wid, height: sizeheight)
        
        
    }
    
    func selectedcate(_ sender:UIButton ) {
        itemsscrollerview.scrollRectToVisible(sender.frame, animated: true)
        
        sender.isSelected = true
        let  i = sender.tag  - 100
        
        let  str = searchresult.categories[i]
        
        if   seletcdelegate != nil {
            searchitem(str)
            seletcdelegate?.selectedindex!(seletcitem, categorie: str)
            
            
        }
        for   btn  in  btns{
            
            if sender != btn {
                btn.isSelected = false
            }
            
        }
        
        
        
        
    }
    func   searchitem(_ str:String) {
        
        if  str == "热门"   {
            seletcitem = searchresult.hot
        }
        else   if  str == "体育"{
             seletcitem = searchresult.sports
        }
        else   if  str == "电影tv"{
             seletcitem = searchresult.movietv
        }
            
        else   if  str == "mv"{
             seletcitem = searchresult.mv
        }
            
        else   if  str == "少儿"{
             seletcitem = searchresult.comickids
        }
            
        else   if  str == "综艺"{
             seletcitem = searchresult.zongyi
            
        }
        if  seletcitem.count == 0 {
            labinfo.text = "无结果"
            lab1.alpha  = 0
            labcount.alpha = 0
            
            
        }
        else {
            lab1.alpha  = 1
            labcount.alpha = 1
            labcount.text =  "\(seletcitem.count)条"
            labinfo.text = "\"" + valuekey + "\""
            
        }
        
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lab1.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnheight)
            maker.top.equalTo(toppadding)
            maker.left.equalTo(leftpadding)
            maker.width.equalTo(40)
            
        }
        labinfo.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnheight)
            maker.top.equalTo(toppadding)
            maker.left.equalTo(leftpadding + 40)
            maker.width.equalTo(keywidth)
            
        }
        labcount.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnheight)
            maker.top.equalTo(toppadding)
            maker.left.equalTo(leftpadding + 40 + keywidth)
            maker.width.equalTo(60)
        }
        
        
        
    }
    
    
    
}
