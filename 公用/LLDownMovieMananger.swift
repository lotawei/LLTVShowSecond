//
//  LLDownMovieMananger.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/1.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
import SQLite
protocol DownMovieManangerpro {
    //下载完成的路径
    func   downloadpath(_ str:URL,_ name:String)
    //下载进度
    func   downitemprogress(_ proinfo:Progress,_ downsuccess:Bool)
    // 出现意外退出需要保存断点
    func    downloadresponse(_ response:DownloadResponse<Data>)

}

//  一个item对应一个  LLDownMovieMananger
class LLDownMovieMananger: NSObject {
    
    static  var  sharemanager:[LLDownMovieMananger] = [LLDownMovieMananger]()
    
    var   delegate:DownMovieManangerpro?
    var  identitystr:String = ""
    
    var   destination:DownloadRequest.DownloadFileDestination?
    
    var  downloadrequest:DownloadRequest!
    
    var   item:LLCategoryRecItem!
    //   下载已完成
    var  isdownloadsuccess:Bool = false
    //
    var  localitempath:URL?
    var   cancleData:Data?
    var   downloaded:Bool = true
    
    
    var   firstsetdown = false
    // 保存当前进度
    var   curpro:Double = 0
    
    override  init(){
        super.init()
        
        
        
    }
   
    convenience  init(_ item:LLCategoryRecItem) {
        self.init()
        self.item = item
        var   identity = ""
        identity =  identity.appending(item.item_title!)
        
        identity = identity.appending(".mp4")
        
    }
    
    convenience  init(_ item:LLCategoryRecItem,_ delegate:DownMovieManangerpro?) {
        self.init()
         self.item = item
        var   identity = ""
        identity =  identity.appending(item.item_title!)
        
        identity = identity.appending(".mp4")
        
        
        self.identitystr = identity
         self.delegate = delegate
    }
    func  setdelegate(_ delegate:DownMovieManangerpro?){
        
        self.delegate = delegate
    }
    
    func startdownitem(){
       
        var   identity = ""
         identity =  identity.appending(item.item_title!)
        
         identity = identity.appending(".mp4")
        
        let  url = item.tvurllink
        
        self.identitystr = identity
        
          weak  var   tmp = self
            self.destination = { _, response in
            let documentsPath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsPath.appendingPathComponent((tmp?.identitystr)!)
            print("下载完成的路径" + fileURL.absoluteString)
            tmp?.localitempath =  fileURL
            tmp?.delegate?.downloadpath(fileURL, (tmp?.item.item_title)!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL,[.removePreviousFile, .createIntermediateDirectories])
        }
        if   cancleData != nil {
            
             self.downloadrequest = download(resumingWith: cancleData!,to: self.destination)
            
        }
        else{
            self.downloadrequest = download(url!, to: self.destination)
            
        }
        self.downloadrequest.downloadProgress(queue: DispatchQueue.main,closure: downloadProgress)
        
        
        self.downloadrequest.responseData(completionHandler: downloadResponse)
    }
    func downloadProgress(progress: Progress) {
        
        if   !firstsetdown {
            downloaded = true
            
            isdownloadsuccess = false
            
            let   lochelper =  LLSqlLiteHelper.share
            lochelper.saveitem(item,self.identitystr,false)
            firstsetdown  = true

        }
        
        
        curpro = progress.fractionCompleted
        
        self.delegate?.downitemprogress(progress,self.isdownloadsuccess)
        
        
    }
    func downloadResponse(response: DownloadResponse<Data>){
        
        switch response.result {
        case .success:
            downloaded = true
            isdownloadsuccess = true
            
            let   lochelper =  LLSqlLiteHelper.share
            lochelper.saveitem(item, self.identitystr,true)
            
            break
        case  .failure:
             downloaded = true
            self.cancleData = response.resumeData
            isdownloadsuccess = false
         
            let   lochelper =  LLSqlLiteHelper.share
            lochelper.saveitem(item,self.identitystr,false)
            
            break
        }
        
        self.delegate?.downloadresponse(response)
    }
    
    
    
    
    func  stopitem(){
        
        if  item != nil {
          self.downloadrequest.cancel()
        }
          
    }
    
    static func   querytask(_ item:LLCategoryRecItem,_ delegate:DownMovieManangerpro?) -> LLDownMovieMananger? {
      
        var   cur = ""
        cur = cur.appending(item.item_title!)
        cur = cur.appending(".mp4")
        for   manager in LLDownMovieMananger.sharemanager{
            if   manager.identitystr == cur{
               
                    manager.delegate  = delegate
                    
                  
                    return  manager
                    
                
               
                
            }
            
            
        }
        
        return  nil
        
    }
    //添加任务项
    static  func  additemanager(_ itemmanager:LLDownMovieMananger) -> Bool{
      
        for   manager in LLDownMovieMananger.sharemanager{
            if   manager.identitystr == itemmanager.identitystr{
                 return false
            }
            
            
            
        }
        LLDownMovieMananger.sharemanager.append(itemmanager)
        
        return  true
        
    }
    
    
    static func   startitem(_ item:LLCategoryRecItem,_ delegate:DownMovieManangerpro?){
        var   cur = ""
        cur = cur.appending(item.item_title!)
        cur = cur.appending(".mp4")
        for   manager in LLDownMovieMananger.sharemanager{
            if   manager.identitystr == cur{
                
                if !manager.isdownloadsuccess {
                   
                    
                    manager.startdownitem()
                    manager.delegate  = delegate
                }
                
            }
            
            
        }
        
    }
    static func   stopitem(_ item:LLCategoryRecItem,_ delegate:DownMovieManangerpro?){
        var   cur = ""
        cur = cur.appending(item.item_title!)
        cur = cur.appending(".mp4")
        for   manager in LLDownMovieMananger.sharemanager{
            if   manager.identitystr == cur{
                if !manager.isdownloadsuccess {
                    manager.stopitem()
                    manager.delegate  = delegate
                }
                
            }
        }
        
    }
    
    static   func  removemanager(_ item:LLCategoryRecItem){
        var   cur = ""
        cur = cur.appending(item.item_title!)
        cur = cur.appending(".mp4")
        let   pos = LLDownMovieMananger.sharemanager.index { (anmager) -> Bool in
            return   anmager.identitystr == cur
        }
        if  pos  != nil {
              LLDownMovieMananger.sharemanager.remove(at: pos!)
        }
       
        
    }
    
    
    
}
