//
//  DownItemCell.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/2.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

@objc protocol  Fullplaypro:NSObjectProtocol {
    
    @objc optional  func goplay(_ identityfile: String)
    
}



class DownItemCell: UITableViewCell ,DownMovieManangerpro{
    
    var   delegate:Fullplaypro?
    
    fileprivate var  itemdata:LLCategoryRecItem!
    @IBOutlet weak var bottomview:UIView!
    @IBOutlet weak var lblname: LLBaseLable!
    @IBOutlet weak var postimg: UIImageView!
   
    @IBOutlet weak var lblyear: LLBaseLable!
    @IBOutlet weak var btnoperate: LLBaseButton!
  
    @IBOutlet weak var progressview:KYCircularProgress!
    
    @IBOutlet weak var lblproinfo: LLBaseLable!
    
    var   curpro = 0.0
    var   itemmangager:LLDownMovieMananger?
    override func awakeFromNib() {
        super.awakeFromNib()
        btnoperate.addTarget(self, action: #selector(changetext(_:)), for: .touchUpInside)
        backgroundColor = UIColor.clear
        contentView.backgroundColor = tablelightcolor
        
        progressview.progressChanged {
            (progress: Double, circularProgress: KYCircularProgress) in
            self.lblproinfo.text = String.init(format: "%.1f", progress * 100.0) + "%"
        }
        progressview.colors = [.white, .groupTableViewBackground, .gray, .darkGray]
       
//        bottomview.gradient(UIColor.white, endcolor: fontcolor)
        // Initialization code
    }
    
    func  changetext(_ sender:UIButton){
          if  sender.titleLabel?.text == "播放"{
            
            
            print(itemmangager?.identitystr)
            if delegate != nil && (delegate?.responds(to: #selector(Fullplaypro.goplay(_:))))!{
                
                
                delegate?.goplay!(itemdata.item_title + ".mp4")
            }
            
            
            
          }
          else if   sender.titleLabel?.text == "暂停"{
                LLDownMovieMananger.stopitem(itemdata, self)
                
            
            
          }
          else if   sender.titleLabel?.text == "继续"{
                LLDownMovieMananger.startitem(itemdata, self)
            
            
            
          }
        
        
        
        
        
        
    }
    func   setitem(_ item:LLCategoryRecItem){
        self.itemdata = item
        postimg.kf.setImage(with: URL(string:item.item_icon1) , placeholder: UIImage(named:"cellimgpalcehold"), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)), KingfisherOptionsInfoItem.forceRefresh], progressBlock: nil, completionHandler: nil)
        
        lblname.text = itemdata.item_title
        
        lblyear.text = itemdata.item_year

        itemmangager =   LLDownMovieMananger.querytask(itemdata,self)
        
        
        if  (itemmangager?.isdownloadsuccess)!{
            btnoperate.setTitle("播放", for: .normal)
            progressview.progress = 1.0
            lblproinfo.text = "已完成"
            itemmangager?.setdelegate(self)
        }
        else if  (itemmangager?.cancleData != nil ){
                progressview.progress = (itemmangager?.curpro)!
            
                btnoperate.setTitle("继续", for: .normal)
            
            
              itemmangager?.setdelegate(self)
        }
        else if  (itemmangager?.cancleData != nil && !(itemmangager?.isdownloadsuccess)! ){
                self.progressview.alpha = 1
                btnoperate.setTitle("暂停", for: .normal)
              itemmangager?.setdelegate(self)
        }
        else {
            
                btnoperate.setTitle("播放", for: .normal)
               self.progressview.alpha = 0
                itemmangager?.setdelegate(self)
        }
        
    }
    //下载完成的路径
    func   downloadpath(_ str:URL,_ name:String){
        print(str.absoluteString)
        
        
    }
    //下载进度
    func   downitemprogress(_ proinfo:Progress,_ downsuccess:Bool)
    {
        
         self.progressview.alpha = 1
        if downsuccess {
            
            progressview.progress = 1.0
            btnoperate.setTitle("播放", for: .normal)
            
            
        }
        else{
          progressview.progress = proinfo.fractionCompleted
          btnoperate.setTitle("暂停", for: .normal)
            
            
        }
        
      
        
    }
    //  下载停止响应
    func    downloadresponse(_ response:DownloadResponse<Data>){
        switch response.result {
        case .success:
            progressview.progress = 1.0
            btnoperate.setTitle("播放", for: .normal)
            lblproinfo.text = "已经下载"
            

            
            
            break
        case .failure:
            
            progressview.progress = (itemmangager?.curpro)!
            
            
            itemmangager?.stopitem()
            
            if   (itemmangager?.isdownloadsuccess)! {
                btnoperate.setTitle("播放", for: .normal)
                return
            }
            if  itemmangager?.cancleData != nil {
                
                btnoperate.setTitle("继续", for: .normal)
                
                
            }
           
            
            break
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
