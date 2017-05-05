//
//  LLAboutViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/13.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
import WebKit
class LLAboutViewController: BaseViewController {
    //  tablelightcolo http://www.jianshu.com/u/d20c314d353d
   
    
    var wkWebView: WKWebView?
    var uiWebView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        self.titleView.text = "关于"

        // Do any additional setup after loading the view, typically from a nib.
        // Get main screen rect size
        
        
        // Construct frame where webview will be pop
        
        
        // Create url request from local index.html file located in web_content
        let url: URL =  URL(string:"http://www.jianshu.com/u/d20c314d353d")!
        
        let requestObj: URLRequest = URLRequest(url: url)
        
        // Test operating system
        if ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) {
            
            self.wkWebView = WKWebView()
            
             _ = self.wkWebView?.load(requestObj)
            self.view.addSubview(self.wkWebView!)
            wkWebView?.snp.makeConstraints({ (maker) in
                maker.width.equalTo(view)
                
                maker.top.equalTo(view)
                maker.bottom.equalTo(view).offset(-kTabBarH)
                maker.left.equalTo(view)
                
            })
            
            
            
        } else {
            
            self.uiWebView = UIWebView()
           _ = self.uiWebView?.loadRequest(requestObj)
            self.view.addSubview(self.uiWebView!)
            uiWebView?.snp.makeConstraints({ (maker) in
                maker.width.equalTo(view)
                
                maker.top.equalTo(view)
                maker.bottom.equalTo(view).offset(-kTabBarH)
                maker.left.equalTo(view)
                
            })
            
        }
        
        
        
    }
    
    
    //Commented:    black status bar.
    //Uncommented:  white status bar.
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
           navigationController?.navigationBar.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
