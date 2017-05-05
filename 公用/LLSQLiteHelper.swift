//
//  LLSQLiteHelper.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/2.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
import SQLite



class  LLSqlLiteHelper:NSObject{
    
    static  let   share:LLSqlLiteHelper =  LLSqlLiteHelper()
    var   db:Connection?
    
    override init() {
        super.init()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        db = try? Connection("\(path)/db.sqlite3")
        print(path)
        
        let str = Table("downtable")
            //   标题名称
        let item_title = Expression<String>("item_title")
            //   影视地址
        let tvurllink = Expression<String?>("tvurllink")
            //   标题海报
        let item_icon1 = Expression<String>("item_icon1")
            //   年份
        let item_year = Expression<String>("item_year")
            //   是否完全下载
         let isdownloadedsuccess = Expression<Bool>("isdownloadedsuccess")
            //   下载过
        let downloaded = Expression<Bool>("downloaded")
            // 作为标识某个影片任务的 字段
        let  item_identity =  Expression<String>("item_identity")
        
        try! db?.run(str.create(ifNotExists: true, block: { (t) in
                    t.column(item_title, primaryKey: true)
                    t.column(tvurllink)
                    t.column(item_identity)
                    t.column(item_icon1)
                    t.column(item_year)
                    t.column(downloaded)
                    t.column(isdownloadedsuccess)
        }))
        
        
        
    }
    func  saveitem(_ item:LLCategoryRecItem?,_ identity:String,_ issuccess:Bool){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let itemtab = Table("downtable")
        let item_title = Expression<String>("item_title")
        let tvurllink = Expression<String?>("tvurllink")
        let item_icon1 = Expression<String>("item_icon1")
        let  item_identity =  Expression<String?>("item_identity")
        let isdownloadedsuccess = Expression<Bool>("isdownloadedsuccess")
        let item_year = Expression<String>("item_year")
        let downloaded = Expression<Bool>("downloaded")
  
        if  db == nil {
    
            db = try? Connection("\(path)/db.sqlite3")
            
        }

        
        let  anewitemisert =   itemtab.insert(item_title <- (item?.item_title)!,tvurllink <- item?.tvurllink,item_icon1 <- (item?.item_icon1)!, item_year <- (item?.item_year)!,downloaded <- true,item_identity <- identity , isdownloadedsuccess <- issuccess )
        if  !isexist((item?.item_title)!){
        
            
            
                try! db?.run(anewitemisert)
        
        }
        else{
            
            let  dbitem = itemtab.filter(item_title == (item?.item_title)!)
            
            try! db?.run(dbitem.update(isdownloadedsuccess <- issuccess))
            print("更新下载字段")
            
        }
        
       
        
       
        
    }
    
    
    func   isexist(_ str:String) -> Bool{
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        if  db == nil {
            db = try? Connection("\(path)/db.sqlite3")
        }
        let itemtab = Table("downtable")
        let item_title = Expression<String>("item_title")
       
        
        
        
         for  dbitem in  (try! db?.prepare(itemtab))!{
            if  dbitem[item_title] == str {
                return  true
            }
        
        }
        return  false
        
    }
    
    func  deleteitem(_ item:LLCategoryRecItem?){
          
        
        
    }
    
    func query() {
        let   locamanager = LLDownMovieMananger()
          let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        if  db == nil {
            db = try? Connection("\(path)/db.sqlite3")
        }
        let itemtab = Table("downtable")
        let item_title = Expression<String>("item_title")
        let tvurllink = Expression<String>("tvurllink")
        let item_icon1 = Expression<String>("item_icon1")
        let isdownloadedsuccess = Expression<Bool>("isdownloadedsuccess")
        let item_year = Expression<String>("item_year")
      
      
        let  item_identity =  Expression<String>("item_identity")
        for  dbitem in  (try! db?.prepare(itemtab))!{
            let   item = LLCategoryRecItem(className: "LLCategoryRecItem")
            item?.item_title = dbitem[item_title]
            item?.tvurllink = dbitem[tvurllink]
            item?.item_icon1 = dbitem[item_icon1]
            item?.item_year = dbitem[item_year]
            item?.downloadsuccess = dbitem[isdownloadedsuccess]
            locamanager.isdownloadsuccess = dbitem[isdownloadedsuccess]
            if  locamanager.isdownloadsuccess {
                locamanager.curpro = 1.0
                locamanager.identitystr = dbitem[item_identity]
                _ = LLDownMovieItems.share.addmovieitem(item!)
                _  =  LLDownMovieMananger.additemanager(locamanager)
            }
          
         
        }
        
    }
    func  cleantab(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
          let litepath =    "\(path)/db.sqlite3"
        
        if(FileManager.default.fileExists(atPath:litepath)){
            // 删除
            try! FileManager.default.removeItem(atPath: litepath)
        }
        
    }
    
    
}

