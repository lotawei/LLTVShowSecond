//
//  LLCollectionViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/4/12.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

let  collectionheight:CGFloat = 300
class LLDetailCollectionViewController: BaseViewController,BMPlayerDelegate,DetailcellProDelegate{

   
   
    
//    lazy  var   titleView :LLBaseLable =  {
//        let titleView = LLBaseLable()
////        titleView.textColor = fontcolor
//        titleView.textAlignment = .center
//        
//        titleView.frame = CGRect(x:0,y:0, width:250,height:30)
//        return titleView
//    }()
    
     var   player:BMPlayer!
    
  
    
    lazy var collectionView: LLBaseCollectionView = {
        let  layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: ScreenWidth, height:collectionheight  )
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
     
        
       
        
        resetPlayerManager()
        view.backgroundColor = UIColor.black
        titleView.text = type
         navigationItem.titleView = titleView
//        titleView.text =  type
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "返回", titleColor: fontcolor,
                                                                     image: UIImage(named: "back")!, hightLightImage: nil,
                                                                     target: self, action: #selector(backaction), type: ItemButtonType.Left)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "分享", titleColor: fontcolor,
                                                                      image: UIImage(named: "分享")!,hightLightImage: nil,
                                                                      target: self, action: #selector(shareaction), type: ItemButtonType.Right)

        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        self.collectionView.register(LLDetailCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.height.equalTo(collectionheight)
            maker.left.equalTo(0)
            maker.top.equalTo(view).offset(kNavigationBarH)
            maker.width.equalTo(ScreenWidth)
        }
        
          initalpalyer()

        // Do any additional setup after loading the view.
    }
     override func listenthenetworkchange() -> Bool {
        return true
    }
    
      func initalpalyer(){
      
        let   contoller = BMPlayerCustomControlView()
        player =  BMPlayer(customControllView: contoller)
            
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true {
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        view.addSubview(player)
        
        player.snp.makeConstraints { (maker) in
            maker.height.equalTo(300)
            maker.left.equalTo(0)
            maker.bottom.equalTo(view).offset(-kTabBarH)
            maker.width.equalTo(ScreenWidth)
        }
        
        
          let  item = itemsdata?[(selectindex?.row)!]
          let url =  URL(string: (item?.tvurllink)!)!
      
     
        
        
        let asset = BMPlayerResource(url:url)
        
        player.setVideo(resource: asset)
            
      
    }
    func resetPlayerManager() {
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = false
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .horizantalOnly
       
    }

    func   backaction(){
        
        _  =  navigationController?.popViewController(animated: true)
        
        
        
    }
    
    func getImage() -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let  image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func   DidClickpreview(_ item: LLCategoryRecItem) {
        
        //  测试s
        BMPlayerConf.shouldAutoPlay = true
        
        let url =  URL(string: item.tvurllink)!
        let asset = BMPlayerResource(url:url)
        
         player.setVideo(resource: asset)
         //预览字段需要在服务器中改为看过
        item.iswatched = true
         let  collectmanager = LLCollectListManager.share
         collectmanager.additem(true, item){   (su,err)  in
            
            
            if  err != nil &&  (err?.localizedDescription.contains("unique"))!{
                
                collectmanager.updateitem(item, { (su, err) in
                    
                })
                return
            }

            
            
        }
        
        
        
    }
    
    func   shareaction(){
        
        let   item = itemsdata?[(selectindex?.row)!]
        
        if  item != nil {
         let shareParames = NSMutableDictionary()
        shareParames.ssdkEnableUseClientShare()
        shareParames.ssdkSetupShareParams(byText: "谁能分享这个玩意儿",
                                                images : getImage(),
                                                url :URL( string:"https://github.com/lwiosbystep"),
                                                title : "一次分享",
                                                type : SSDKContentType.image)
        
        //2.进行分享
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: shareParames) { (state, type, datas, entity, err, success) in
            if success {
                _ = SweetAlert().showAlert("分享成功！")
            }
            
         }
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
        
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法
        player.pause(allowAutoPlay: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法
        navigationController?.navigationBar.isHidden  = false
        player.autoPlay()
    }
    func bmPlayer(player: BMPlayer ,playerStateDidChange state: BMPlayerState)
    {
        
        
        
       
        
    }
    func bmPlayer(player: BMPlayer ,loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval){
        
    }
    func bmPlayer(player: BMPlayer ,playTimeDidChange currentTime : TimeInterval, totalTime: TimeInterval){
        
    }
    func bmPlayer(player: BMPlayer ,playerIsPlaying playing: Bool){
        
    }
    deinit {
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法手动销毁
        player.prepareToDealloc()
        print("VideoPlayViewController Deinit")
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
        cell?.delegate = self
        return cell!
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  path = collectionView.indexPathForItem(at:CGPoint(x: scrollView.contentOffset.x,y:scrollView.contentOffset.y))
        if   path != nil {
            selectindex = path!
        }
        
        
    }
    
 

    
  
}
