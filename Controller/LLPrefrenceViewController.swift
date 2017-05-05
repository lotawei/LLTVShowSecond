//
//  LLPrefrenceViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/4.
//  Copyright © 2017年 lotawei. All rights reserved.
// override func viewDidLoad() {

import UIKit

class LLPrefrenceViewController: BaseViewController ,SelectCategoriesPro,UITableViewDelegate,UITableViewDataSource ,LTMorphingLabelDelegate{
    
    
    
    lazy var  lblshow:LTMorphingLabel = {
        let  lab = LTMorphingLabel()
        lab.delegate = self
        lab.morphingDuration =  1.5
        lab.textColor = UIColor.black
        lab.morphingEffect = .burn
        lab.font = UIFont.systemFont(ofSize: 16)
        lab.text = "推荐中..."
        
        
        return  lab
    }()
    
    
    
    var   resultheadview:LLResultHeadView!
    
    var   items:[LLCategoryRecItem] = [LLCategoryRecItem]()
    
    
    lazy  var   tableview:LLBaseTableView = {
        let  tabl = LLBaseTableView(frame: CGRect.zero, style: .plain)
        return  tabl
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = "瞎乱推荐"
        
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        titleView.text = key!
//        resultheadview = LLResultHeadView(frame: CGRect.zero, key: key!)
        resultheadview.seletcdelegate = self
        view.addSubview(resultheadview)
        
//        let  strkey = String.transformToPinYin(str: key!)
        
        tableview.delegate = self
        tableview.dataSource = self
        let cellNib = UINib(nibName: "LLResultItemCell", bundle: nil)
        
        tableview.register(cellNib, forCellReuseIdentifier: cellid)
        view.addSubview(tableview)
        
        
        tableview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            maker.height.equalTo(ScreenHeight - kTabBarH - kNavigationBarH  - resultheadview.height)
            maker.left.equalTo(0)
            maker.top.equalTo(resultheadview.bottom)
        }
        view.addSubview(lblshow)
        lblshow.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(view)
            maker.height.equalTo(30)
            maker.width.equalTo(60)
            maker.centerY.equalTo(view)
            
        }
        
//        
    }
    
    
    func selectedindex(_ items: [LLCategoryRecItem], categorie: String) {
        
        self.items = items
        
        tableview.reloadData()
        
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
