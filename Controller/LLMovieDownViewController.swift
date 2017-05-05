//
//  LLMovieDownViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/5/2.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

class LLMovieDownViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource ,Fullplaypro{
    
    lazy  var   tableview:LLBaseTableView = {
        let  tabl = LLBaseTableView(frame: CGRect.zero, style: .plain)
        return  tabl
        
    }()
    
    
    
    //  当前的玩意儿
   lazy var   items:[LLCategoryRecItem] = {
        let   adb = LLSqlLiteHelper.share
        adb.query()
        let    downitems = LLDownMovieItems.share.items
        return downitems
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = "下载的视频"
        navigationController?.navigationBar.isHidden = false
        tableview.delegate = self
        tableview.dataSource = self
        let cellNib = UINib(nibName: "DownItemCell", bundle: nil)
        
        tableview.register(cellNib, forCellReuseIdentifier: cellid)
        view.addSubview(tableview)
        
        
        tableview.snp.makeConstraints { (maker) in
            maker.width.equalTo(view)
            maker.bottom.equalTo(view).offset(-kTabBarH)
            maker.left.equalTo(0)
            maker.top.equalTo(0)
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
            tableview.reloadData()
        
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
        var   cell = tableview.dequeueReusableCell(withIdentifier: cellid) as? DownItemCell
        
        if  cell == nil {
            
            cell = DownItemCell(style: .default, reuseIdentifier: cellid)
            
        }
        cell?.setitem(item)
        cell?.delegate = self
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  120
    }
    
    
    
    func goplay(_ identityfile: String) {
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
        let fileURL = documentsPath.appendingPathComponent(identityfile)
        
        let   vdvc = LLFullLandScreenViewController()
        vdvc.vidopath = fileURL.relativePath
        
        
        
        self.navigationController?.pushViewController(vdvc, animated: true)
        
        
        
        
    }

}
