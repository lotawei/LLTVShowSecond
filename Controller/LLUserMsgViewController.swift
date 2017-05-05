//
//  LLUserMsgViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/4.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLUserMsgViewController: BaseViewController {
    var   tabdata:[LLRevertLayout] = [LLRevertLayout]()
    var   tableview:LLBaseTableView!
    lazy var refreshHeadView:LLRefreshView = {
        let refreshHeadView = LLRefreshView(refreshingTarget: self, refreshingAction: #selector(LLAdminViewController.headRefresh))
        return refreshHeadView!
    }()
    func  headRefresh(){
        var   finish = false
        
        LLRevertMsg.getallpermsgs { [weak self] (msgs) in
            
            if   msgs == nil {
                finish  = true
                
            }
            else {
                
                
                self?.tabdata = msgs!
                finish = true
                
                
            }
            if  finish {
                
                self?.tableview.reloadData()
            }
            self?.tableview.mj_header.endRefreshing()
            
            
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.titleView.text = "管理员"
        
       
        tableview = LLBaseTableView(frame: CGRect.zero, style: .plain)
        
        tableview.delegate = self
        tableview.dataSource = self
        //        let refreshHeadView = LLRefreshView(refreshingTarget: self, refreshingAction: "headRefresh")
        refreshHeadView.gifView?.frame = CGRect(x:0, y:30, width:100, height:100)
        tableview.mj_header = refreshHeadView
        
        
        tableview.register(RevertCell.self,
                           forCellReuseIdentifier:"cell")
        
        view.addSubview(tableview!)
        
        
        tableview.snp.makeConstraints { (maker) in
            maker.height.equalTo(ScreenHeight - kStatusBarH - kNavigationBarH)
            
            maker.width.equalTo(ScreenWidth)
            maker.left.equalTo(0)
            maker.top.equalTo(0)
            
        }
        headRefresh()
    }


}
extension   LLUserMsgViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   tabdata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let   revert = tabdata[indexPath.row]
        
        var   cell = tableview.dequeueReusableCell(withIdentifier: "cell") as? RevertCell
        if  cell == nil {
            
            cell = RevertCell(style: .default, reuseIdentifier: "cell")
            
        }
        //设置 cell
        cell!.setrevert(revert)
        
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let   revert = tabdata[indexPath.row]
        
        return  revert.cellheight
    }
    
  

    
}
