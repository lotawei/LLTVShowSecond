//
//  LLCollectedViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/27.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLCollectedViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
 
   
    
   
    
   lazy var   items:[LLCategoryRecItem] = {
        var   newitems = [LLCategoryRecItem]()
        let   items =   LLCollectListManager.share.collectionitems
    
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
        
        titleView.text = "个人收藏"
        navigationController?.navigationBar.isHidden = false
        
        
        
        
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableview.setEditing(editing, animated: animated)
    }

    //指定可编辑的行
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return  true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return  UITableViewCellEditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == UITableViewCellEditingStyle.delete{
            
            let item  = items[indexPath.row]
            
            item.iscollected = false
            let   amamnager = LLCollectListManager.share
            weak  var  tmp = self
            tmp?.activityIndicatorView.startAnimating()
            amamnager.delete(item, { (su, err) in
                if su  {
                    
                    tmp?.items.remove(at: indexPath.row)
                    tmp?.tableview.deleteRows(at: [indexPath], with: .automatic)
                    
                }
                if  err != nil {
                    _  = SweetAlert().showAlert("删除失败")
                    return
                }
                 tmp?.activityIndicatorView.stopAnimating()
                
                
            })
            
            
            
            
            
        }
    }

   
}
