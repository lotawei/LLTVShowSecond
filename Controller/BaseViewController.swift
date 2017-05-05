//
//  BaseViewController.swift
//  LLTVShow
//
//  Created by lotawei on 16/11/27.
//  Copyright © 2016年 lotawei. All rights reserved.
//


//  导航条需要隐藏的    就继承 base 下个页面有跳转的需要在界面消失让导航条显示  不需要隐藏的就继承uiviewcontroller
import UIKit

class BaseViewController: UIViewController {
    lazy var     manager:NetworkReachabilityManager = {
        
        
        let  anamager = NetworkReachabilityManager(host: "www.apple.com")
        return anamager!
    }()
    func  listenthenetworkchange() -> Bool{
        
        return  false
    }
    
    
    let  activityIndicatorView  = NVActivityIndicatorView(frame: CGRect.zero, type: .ballPulse, color: fontcolor, padding: 1)
    lazy  var   titleView :LLBaseLable =  {
        let titleView = LLBaseLable()
        
        titleView.textAlignment = .center
        
        titleView.frame = CGRect(x:0,y:0, width:250,height:30)
        return titleView
    }()
    
    func   hiddenbar() -> Bool {
        return  false
    }
    deinit {
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationSelect), object: nil)
        print("base释放")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        
        navigationController?.navigationBar.isHidden =  hiddenbar()
        view.backgroundColor = LLCurrentUser.currentuser.user==nil ? normalcolor : LLCurrentUser.currentuser.user.substyle.substyleimgcolor()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listenthenetworkchange() {
            manager.startListening()
            manager.listener = { status in
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
                    _ =  SweetAlert().showAlert("网路怕是不对哦")
                }
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown {
                }
                if  status ==  NetworkReachabilityManager.NetworkReachabilityStatus.reachable(.wwan){
                    _ =  SweetAlert().showAlert("你正在使用流量")
                }
                
            }
        }
        
        
        
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { (maker) in
            maker.width.height.equalTo(150)
            maker.center.equalTo(view)
            
            
        }
        NOTIfyCenter.addObserver(self, selector: #selector(BaseViewController.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
        NOTIfyCenter.addObserver(self, selector: #selector(BaseViewController.basegetnotify(_:)), name: NSNotification.Name(rawValue: notificationSelect), object: nil)
        
        
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.titleView = titleView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func  basegetnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
            
        case LLPOSDarkStyle:
            if LLCurrentUser.currentuser.user != nil {
                _ =  LLCurrentUser.currentuser.user.substyle =  Substyle.dark
                _  =   LLCurrentUser.currentuser.user.saveuser()
            }
            UIView.animate(withDuration: 0.6, animations: {
                self.view.backgroundColor = tablebackcolor
            })
            
            
            
            break;
        case LLPOSLightStyle:
            if LLCurrentUser.currentuser.user != nil {
                _ =  LLCurrentUser.currentuser.user.substyle =  Substyle.normal
                _ =  LLCurrentUser.currentuser.user.saveuser()
            }
            UIView.animate(withDuration: 0.6, animations: {
                self.view.backgroundColor = tablelightcolor
            })
            
            
            break;
        case  LLPOSEyeStyle:
            if LLCurrentUser.currentuser.user != nil {
                _ =  LLCurrentUser.currentuser.user.substyle =  Substyle.eyeprotect
                _ =  LLCurrentUser.currentuser.user.saveuser()
            }
            UIView.animate(withDuration: 0.6, animations: {
                self.view.backgroundColor = tableeyecolor
            })
            
            
            
            
            break;
        default:
            break;
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor =   LLCurrentUser.currentuser.user == nil  ?  normalcolor : LLCurrentUser.currentuser.user.substyle.substylecolor()
        UIApplication.shared.isStatusBarHidden = true
        LLCollectListManager.share.queryitems()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if  !hiddenbar(){
            
            navigationController?.navigationBar.isHidden = false
        }
    }
    func cleancahe()  {
        
        let cache = KingfisherManager.shared.cache
        var  kingfishercachesize:Double  =  0
        cache.calculateDiskCacheSize { (size) in
            kingfishercachesize  = Double(size)
        }
        
        
        //         取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let testpath  = cachePath?.appending("/test.data")
        //  为了测试呢 就随便写点东西
        let   astrdata = "测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据测试缓存数据"
        let    data = astrdata.data(using: .utf8)
        try!  data?.write(to: URL(fileURLWithPath: testpath!))
        let files = FileManager.default.subpaths(atPath:cachePath!)
        var big = Double();
        //         快速枚举取出所有文件名
        for p in files!{
            // 把文件名拼接到路径中
            let path = cachePath!.appendingFormat("/\(p)")
            if  path != userAccountPath  {
                // 取出文件属性
                let floder = try! FileManager.default.attributesOfItem(atPath: path)
                // 用元组取出文件大小属性
                for (abc,bcd) in floder {
                    // 只去出文件大小进行拼接
                    if abc == FileAttributeKey.size{
                        big += (bcd as AnyObject).doubleValue
                    }
                }
            }
        }
        
        big  = big + kingfishercachesize
        let message = String.transformedValue(big as AnyObject)
        SweetAlert().showAlert("确定要删除?", subTitle: message, style: AlertStyle.warning, buttonTitle:"取消", buttonColor:btncolor , otherButtonTitle:  "删除", otherButtonColor: btncolor) { (isOtherButton) -> Void in
            if isOtherButton == true {
            }
            else {
                for p in files!{
                    // 拼接路径
                    let path = cachePath!.appendingFormat("/\(p)")
                    if  path != userAccountPath  {
                        // 判断是否可以删除
                        if(FileManager.default.fileExists(atPath:path)){
                            // 删除
                            do{
                                cache.clearDiskCache()//清除硬盘缓存
                                cache.clearMemoryCache()//清理网络缓存
                                cache.cleanExpiredDiskCache()//清理过期的，或者超过硬盘限制大小的
                                
                                try FileManager.default.removeItem(atPath: path)
                                _ =   SweetAlert().showAlert("Deleted!", subTitle: "清理成功", style: AlertStyle.success)
                            }catch{
                                
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
}

