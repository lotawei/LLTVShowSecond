//
//  LLCollectionViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/12.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LLDetailCollectionViewController: BaseViewController {
   
    
    lazy var collectionView: LLBaseCollectionView = {
        let  layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: ScreenWidth, height:ScreenHeight  )
        let      collectionView = LLBaseCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        
        
        
        
        return collectionView
    }()
    var  type:String = "未知"
    
    var  itemsdata:[LLCategoryRecItem]?
    var  selectindex:IndexPath?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text =  type
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "返回", titleColor: fontcolor,
                                                                     image: UIImage(named: "back")!, hightLightImage: nil,
                                                                     target: self, action: #selector(backaction), type: ItemButtonType.Left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "分享", titleColor: fontcolor,
                                                                      image: UIImage(named: "分享")!,hightLightImage: nil,
                                                                      target: self, action: #selector(shareaction), type: ItemButtonType.Right)
        

//        edgesForExtendedLayout = .top
//        
//        automaticallyAdjustsScrollViewInsets = false
//        self.collectionView.isPagingEnabled  = true
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        self.collectionView.register(LLDetailCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        
        
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.height.equalTo(ScreenHeight  )
            maker.left.equalTo(0)
            maker.top.equalTo(0)
            maker.width.equalTo(ScreenWidth)
        }
    
        
        
        // Do any additional setup after loading the view.
    }
    func   backaction(){
        
        _  =  navigationController?.popViewController(animated: true)
        
        
        
    }

    
    func   shareaction(){
        
        let shareParames = NSMutableDictionary()
        
        shareParames.ssdkSetupShareParams(byText: "分享内容",
                                                images : UIImage(named: "share"),
                                                url : NSURL(string:"http://mob.com") as URL!,
                                                title : "分享标题",
                                                type : SSDKContentType.image)
        
        //2.进行分享
        ShareSDK.share(.typeQQ, parameters: shareParames) { (state, others, entity, err) in
            
            if  err != nil {
                print(err)
            }
            print(state.rawValue)
            
            
            
        }
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   
        
        if  selectindex != nil {
            
            collectionView.scrollToItem(at: selectindex!, at: .left, animated: false)
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
  
  
}
extension  LLDetailCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return  (itemsdata?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var    cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LLDetailCollectionViewCell
        let   item  = itemsdata?[indexPath.row]
        
        if   cell == nil {
            cell = LLDetailCollectionViewCell()

        }
        cell?.backgroundColor = UIColor.black
        cell?.setitem(item!)
        
        return cell!
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  path = collectionView.indexPathForItem(at:CGPoint(x: scrollView.contentOffset.x,y:scrollView.contentOffset.y))
        if   path != nil {
            selectindex = path!
        }
        
        
    }
    
    
  
}
