//
//  LLTVListViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/2/10.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLTVListViewController: BaseViewController {
    let  cellid = "myCell"
    lazy  var   infotitleView :IndexTittleView =  {
    let titleView = IndexTittleView.shareview()
    titleView.backgroundColor = normalcolor
    titleView.layer.cornerRadius = 5
    titleView.frame = CGRect(x:0,y:0, width:250,height:30)
        return titleView
    }()
    
    var   weathinfo:LLWeatherInfo!
    
    var    tableview:LLBaseTableView!
    var    tabdata:[LLContenCategory] = [LLContenCategory]()
    lazy var refreshHeadView:LLRefreshView = {
        let refreshHeadView = LLRefreshView(refreshingTarget: self, refreshingAction: #selector(LLTVListViewController.headRefresh))
        
        
        return refreshHeadView!
    }()
      func  headRefresh(){
        
        

      
      
        var   finish = false
        
      LLAuthManager.Authorizon(opentvurl,   datablock: { (data) in
            unowned let  tmp  = self
            
        
            if  data.result.error != nil {
                 _  = SweetAlert().showAlert("服务器验证失败")
                tmp.navigationItem.prompt = "";
                 tmp.tableview.mj_header.endRefreshing()
                
            }
            else{
            LLContenCategory.GetContenCategory(data, { (categories) in
                
                tmp.tabdata = categories!
                
                finish = true
                if  finish {
                 tmp.tableview.mj_header.endRefreshing()
                 tmp.tableview.reloadData()
                

                    
                }
            })
            }
            
            
            
        })
        
    }
 
    
    private func buildNavigationItem() {
        
        
        navigationController?.navigationBar.backgroundColor = normalcolor
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: fontcolor,
                                                                     image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil,
                                                                     target: self, action: #selector(codeaction), type: ItemButtonType.Left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜 索", titleColor: fontcolor,
                                                                      image: UIImage(named: "icon_search")!,hightLightImage: nil,
                                                                      target: self, action: #selector(searchaction), type: ItemButtonType.Right)
        
        
        
   
        navigationItem.titleView = infotitleView
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(titleViewClick))
        navigationItem.titleView?.addGestureRecognizer(tap)
       
    }
    func   codeaction(){
        //
        let qrCode = LLCodeScanViewController()
        navigationController?.pushViewController(qrCode, animated: true)
        
    }
    func   searchaction(){
        
    }
    func   titleViewClick(){
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        //  左上角   扫一扫
        buildNavigationItem()
   
        //  本月最新
        
        LLWeatherInfo.getweather {[weak self] (model) in
            if  model != nil {
            self?.infotitleView.setinfo(model!)
            }
            
        }
        
        
        
        tableview = LLBaseTableView(frame: CGRect.zero, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
//        let refreshHeadView = LLRefreshView(refreshingTarget: self, refreshingAction: "headRefresh")
        refreshHeadView.gifView?.frame = CGRect(x:0, y:30, width:150, height:100)
        tableview.mj_header = refreshHeadView
        
        
        tableview.register(LLCategoryCell.self,
                            forCellReuseIdentifier:cellid)
        view.addSubview(tableview!)
        headRefresh()
        
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        tableview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            maker.height.equalTo(ScreenHeight - kTabBarH - kNavigationBarH - kStatusBarH)
            maker.left.equalTo(0)
            maker.top.equalTo(0)
        }
       
    }
    
 
 

        
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if  (navigationController?.viewControllers.count)! > 0 {
               navigationController?.navigationBar.isHidden  = false
        }
    }
    deinit {
        print("LLTVListViewController释放")
    }
    


}

extension LLTVListViewController:UITableViewDelegate,UITableViewDataSource,ItemViewProDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   tabdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        let   category = tabdata[indexPath.row]
        
        var   cell = tableview.dequeueReusableCell(withIdentifier: cellid) as?  LLCategoryCell
        if  cell == nil {
            
            cell = LLCategoryCell(style: .default, reuseIdentifier: cellid)
            
        }
        
        //设置 cell
        cell!.setcategory(category)
        cell!.delegate = self
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return   ScreenWidth +  90
    }
    func  DidClickItemCell(_ type:String,_ item: [LLCategoryRecItem], _ selectindex: IndexPath) {
          
        let  details  = LLDetailCollectionViewController()
        details.type = type
        details.itemsdata = item
        details.selectindex = selectindex
        navigationController?.pushViewController(details, animated: true)
    }
    
}


