//
//  LLWatchedViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLWatchedViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    lazy var   items:[LLCategoryRecItem] = {
        var   newitems = [LLCategoryRecItem]()
        let   items =   LLCollectListManager.share.watcheditems
        
        for   item in items {
            
            newitems.append(item.trancategorieitem())
            
        }
        return newitems
        
    }()
    
    
    lazy  var   tableview:LLBaseTableView = {
        let  tabl = LLBaseTableView(frame: CGRect.zero, style: .plain)
        return  tabl
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden  = false
        titleView.text = "浏览记录"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableview.delegate = self
        tableview.dataSource = self
        
        

        
        
        let cellNib = UINib(nibName: "LLResultItemCell", bundle: nil)
        
        tableview.register(cellNib, forCellReuseIdentifier: cellid)
        view.addSubview(tableview)
        
        
        tableview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            maker.height.equalTo(ScreenHeight - kTabBarH - kNavigationBarH )
            maker.left.equalTo(0)
            maker.top.equalTo(0)
        }
        

        // Do any additional setup after loading the view.
    }
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
   }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return  1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let   item = items[indexPath.row]
        var   cell = tableview.dequeueReusableCell(withIdentifier: cellid) as? LLResultItemCell
        
        if  cell == nil {
            
            cell = LLResultItemCell(style: .default, reuseIdentifier: cellid)
            
        }
        cell?.setitem(item)
        
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let   detailsvc = LLDetailCollectionViewController()
        
        detailsvc.itemsdata = items
        detailsvc.selectindex = indexPath
        
        self.navigationController?.pushViewController(detailsvc, animated: true)
    }
    
    
    
    
    
}

