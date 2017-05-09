//
//  LLSearchViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/21.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
class LLSearchViewController: YNSearchViewController ,YNSearchDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
           view.backgroundColor = UIColor.init(patternImage: UIImage(named:"background")!)
        edgesForExtendedLayout = .top
        
        YNSearch.firstload()
        self.ynSearchinit()
        self.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.ynSearchView.ynSearchMainView.setYNCategoryButtonType(type: .border)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
         self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func ynSearchHistoryButtonClicked(text: String) {
        self.pushViewController(text)
        print(text)
    }
    
    func ynCategoryButtonClicked(text: String) {
        self.pushViewController(text)
        print(text)
    }
    
    func ynSearchListViewClicked(text: String) {
        self.pushViewController(text)
        print(text)
    }
    func   pushViewController(_ key:String){
        
        let   resultvc = LLResultViewController()
        
        resultvc.key = key
        
        navigationController?.pushViewController(resultvc, animated: true)
        
        
    }
    
   

}
