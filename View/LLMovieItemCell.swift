//
//  LLMovieItemCell.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/8.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
class LLMovieItemCell: UICollectionViewCell,LTMorphingLabelDelegate {
    //上边距
    let  toppadding:CGFloat = 5
    
    //  上下间距
    let  lblpadding:CGFloat  = 24
    let  imgwidth:CGFloat = 208
    let  imgheight:CGFloat = 300
    
    
    // 描述
    let  lblwidth:CGFloat = 27
    
    let  lblheight:CGFloat = 21
    let  scorewidth:CGFloat = 60
    // 具体放数据
    let  lbltxtwitdh:CGFloat = ScreenWidth - 208 - 27 - 2 * 15
    let  lbltxtheight:CGFloat  = 21
    //  影片图片
    lazy  var   itemimg:UIImageView = {
        
        let    imgview = UIImageView()
        imgview.isUserInteractionEnabled = true
        imgview.contentMode = .scaleToFill
        return  imgview
        
    }()
    // 是否高清
    lazy var  lblhd:UILabel = {
        
        let  alab = UILabel()
        //        alab.delegate = self
        //        alab.morphingDuration = 2.0
        alab.textColor = UIColor.yellow
        alab.font = UIFont.systemFont(ofSize: 14)
        
        alab.textAlignment = .right
        
        return  alab
    }()
    
    // 影片名称
    lazy var  lblitemtitle:UILabel = {
        //        let  alab = LTMorphingLabel()
        //        alab.delegate = self
        //        alab.morphingDuration = 2.0
        //        alab.textColor = UIColor.white
        //        alab.font = UIFont.systemFont(ofSize: 16)
        //        alab.morphingEffect = .burn
        //        alab.textAlignment = .center
        let  alab = UILabel()
        //        alab.delegate = self
        //        alab.morphingDuration = 2.0
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 16)
        //        alab.morphingEffect = .burn
        alab.textAlignment = .center
        
        return  alab
    }()
    //导演
    lazy  var  lbldirector:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "导演:"
        alab.textAlignment = .left
        return  alab
    }()
    
    //
    lazy var  lbldirectxt:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.gray
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.textAlignment = .left
        return  alab
    }()
    //主演
    lazy var  lblcast:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "主演:"
        alab.textAlignment = .left
        return  alab
    }()
    lazy var  lblcasttxt:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.gray
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.textAlignment = .left
        return  alab
    }()
    //标签
    lazy  var  lbltag:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "标签:"
        alab.textAlignment = .left
        return  alab
    }()
    //
    lazy var  lbltagttxt:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.gray
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.textAlignment = .left
        return  alab
    }()
    
    //地区
    lazy var  lblarea:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "地区:"
        alab.textAlignment = .left
        return  alab
    }()
    //
    lazy var  lblareatxt:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.gray
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.textAlignment = .left
        return  alab
    }()
    
    
    //年份
    lazy var  lblyear:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "年份:"
        alab.textAlignment = .left
        return  alab
    }()
    //
    lazy var  lblyeartxt:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.gray
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.textAlignment = .left
        return  alab
    }()
    // 评价
    lazy  var  lblscore:UILabel = {
        let  alab = UILabel()
        
        
        alab.textColor = UIColor.white
        alab.font = UIFont.systemFont(ofSize: 10)
        alab.text = "评价:"
        alab.textAlignment = .left
        return  alab
    }()
    //
    lazy var  lblscoretxt:UILabel = {
        let  alab = UILabel()
        
        
//        alab.textColor = fontcolor
        alab.font = UIFont.systemFont(ofSize: 14)
        alab.textAlignment = .left
        return  alab
    }()
    
    lazy  var   scoreimg:UIImageView = {
        
        let    imgview = UIImageView()
        imgview.isUserInteractionEnabled = true
        imgview.contentMode = .scaleToFill
        
        return  imgview
        
        
    }()
    lazy  var   btndownload:UIButton = {
        let   btn  =  UIButton()
        btn.showsTouchWhenHighlighted = true
        btn.tag = 1000 //1000未收藏  10001 收藏
        btn.setTitle("下载", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return  btn
        
    }()
    
    lazy  var   btncollect:UIButton = {
        let   btn  =  UIButton()
        btn.showsTouchWhenHighlighted = true
        btn.tag = 1000 //1000未收藏  10001 收藏
        btn.setTitle("收藏", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return  btn
        
    }()
    
    var   itemmodel:LLCategoryRecItem? = LLCategoryRecItem()
    override   init(frame:CGRect){
        
        
        
        super.init(frame: frame)
        
        
        itemimg.addSubview(lblhd)
        contentView.addSubview(itemimg)
        contentView.addSubview(lblitemtitle)
        contentView.addSubview(lbldirector)
        contentView.addSubview(lbltag)
        contentView.addSubview(lblarea)
        contentView.addSubview(lblcast)
        contentView.addSubview(lblyear)
        contentView.addSubview(lblscore)
        
        contentView.addSubview(lbltagttxt)
        contentView.addSubview(lblscoretxt)
        contentView.addSubview(lblyeartxt)
        contentView.addSubview(lblareatxt)
        contentView.addSubview(lblcasttxt)
        contentView.addSubview(lbldirectxt)
        contentView.addSubview(scoreimg)
        contentView.addSubview(btndownload)
        contentView.addSubview(btncollect)
        
        btncollect.addTarget(self, action: #selector(collection), for: .touchUpInside)
        btndownload.addTarget(self, action: #selector(download), for: .touchUpInside)
        initalframe()
        //
        
        
        
        
        
    }
    func  download(){
        
        
        
        if  itemmodel == nil  {
            return
        }
        //点击时  将
        itemmodel?.iscollected = true
        let   curuser =     LLCurrentUser.currentuser.user
        if   curuser == nil {
            _  = SweetAlert().showAlert("尚未登录")
            return
        }
        
        
        
        if   LLDownMovieItems.share.addmovieitem(self.itemmodel!){
            let    animationimg  = UIImageView(image: itemimg.image)
            contentView.addSubview(animationimg)
            animationimg.snp.makeConstraints { (maker) in
                maker.size.equalTo(itemimg).multipliedBy(208.0/300.0)
                maker.center.equalTo(itemimg)
            }
            animationimg.cubeAnimate()
            LLDownMovieMananger.startitem(self.itemmodel!, nil)
            
            
        }
        else{
      
             _  = SweetAlert().showAlert("已添加至下载列表")
            
        }
    
    }
    func   collection(){
        if  itemmodel == nil  {
            return
        }
        //点击时  将
        itemmodel?.iscollected = true
        let   curuser =     LLCurrentUser.currentuser.user
        if   curuser == nil {
            _  = SweetAlert().showAlert("尚未登录")
            return
        }
        let   amanager = LLCollectListManager.share
        weak var  tmp = self
        amanager.additem(false,itemmodel!) { (su, err) in
            
            
            if  err != nil &&  (err?.localizedDescription.contains("unique"))!{
                
                    amanager.updateitem((tmp?.itemmodel)!, { (su, err) in
                        
                        if  su {
                            
                            _  = SweetAlert().showAlert("该项已经收藏")
                            
                        }
                        
                        
                        
                    })
                

                
                return
            }
            if  err  == nil &&  su {
                _  = SweetAlert().showAlert("收藏成功")
                return
            }
            if  su == false{
                 _  = SweetAlert().showAlert("收藏失败")
                return
            }
            
            
        }
        
        
        
        
        
    }
    
    
    func   setitem(_ item:LLCategoryRecItem){
        itemmodel = item
        itemimg.kf.setImage(with: URL(string:item.item_icon1) , placeholder: UIImage(named:"cellimgpalcehold"), options:  [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        lblitemtitle.text = item.item_title
        lbldirectxt.text = item.displaydirector()
        lblcasttxt.text = item.displaycast()
        lbltagttxt.text = item.displaytag()
        lblyeartxt.text = item.item_year
        lblscoretxt.text = item.item_score
        lblareatxt.text = item.displayarea()
        let   score = item.item_score.StringToFloat()
        if   score >= 7.0 {
            scoreimg.image = UIImage(named:"hot")
        }else  if  score > 5.0 &&  score < 7 {
            scoreimg.image = UIImage(named:"mid")
        }
        else{
            scoreimg.image = UIImage(named:"little")
        }
        lblhd.text = item.item_isHd == "0" ? "高清":""
        
        
        
        
    }
    func initalframe() {
        
        
        lblitemtitle.snp.makeConstraints { (maker) in
            
            maker.top.equalTo(imgheight + 2 * toppadding )
            maker.left.equalTo(toppadding)
            maker.width.equalTo(imgwidth)
            maker.height.equalTo(30)
        }
        
        itemimg.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding)
            maker.left.equalTo(toppadding)
            maker.width.equalTo(imgwidth)
            maker.height.equalTo(imgheight)
        }
        
        lblhd.snp.makeConstraints { (maker) in
            maker.width.equalTo(100)
            maker.height.equalTo(30)
            maker.right.equalTo(itemimg.right - 10)
            maker.bottom.equalTo(itemimg.bottom )
            
        }
        lbldirector.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding)
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lbldirectxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding)
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth)
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
        }
        
        
        lblcast.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + lblheight + lblpadding)
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lblcasttxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + lblheight + lblpadding)
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth)
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
        }
        
        lbltag.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 2 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lbltagttxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 2 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth)
            
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
        }
        
        
        
        lblarea.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 3 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lblareatxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 3 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth )
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
        }
        lblyear.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 4 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2  )
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
            
        }
        //
        lblyeartxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 4 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth )
            maker.width.equalTo(lbltxtwitdh)
            maker.height.equalTo(lbltxtheight)
            
        }
        
        
        lbltag.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 4 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lbltagttxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 4 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth)
            maker.width.equalTo(scorewidth)
            maker.height.equalTo(lblheight)
        }
        
        lblscore.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 5 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2)
            maker.width.equalTo(lblwidth)
            maker.height.equalTo(lblheight)
        }
        //
        lblscoretxt.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 5 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth)
            maker.width.equalTo(scorewidth)
            maker.height.equalTo(lblheight)
        }
        
        //
        scoreimg.snp.makeConstraints { (maker) in
            maker.top.equalTo(toppadding + 5 *  (lblheight  +  lblpadding))
            maker.left.equalTo(imgwidth + toppadding * 2 + lblwidth + scorewidth)
            maker.width.equalTo(lblheight)
            maker.height.equalTo(lblheight)
        }
        btndownload.snp.makeConstraints { (maker) in
            maker.top.equalTo( imgheight + 2 * toppadding)
            maker.width.equalTo(60)
            
            maker.height.equalTo(30)
            maker.right.equalTo(-2*toppadding - 60  )
            
            
        }
        
        btncollect.snp.makeConstraints { (maker) in
            maker.top.equalTo( imgheight + 2 * toppadding)
            maker.width.equalTo(60)
            
            maker.height.equalTo(30)
            maker.right.equalTo(-toppadding)
            
            
        }
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
}
