//
//  LLAcountViewController.swift
//  LLTVShow
//
//  Created by lotawei on 17/2/10.
//  Copyright © 2017年 lotawei. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
class LLAcountViewController: BaseViewController {
    var sourceType:UIImagePickerControllerSourceType!
    let   mainscrollerview:UIScrollView! = nil
    // 数据  暂时先自己构建吧
   //  marking－warning   循环引用
    let   accoutlistdata =  [
        [["info":"我的消息","icon":"message","isdefault":"default"]],
        [ ["info":"下载的视频","icon":"VIP","isdefault":"default"],
          ["info":"猜你喜欢","icon":"intersting","isdefault":"default"],
          ["info":"主题皮肤","icon":"skin","isdefault":"default"]
        ],
        [ ["info":"夜间模式","icon":"darkstyle","isdefault":"on"],
          ["info":"反馈意见","icon":"revert","isdefault":"default"],
          ["info":"清理缓存","icon":"clean","isdefault":"default"],
          ["info":"关于","icon":"about","isdefault":"default"]
        ]
        
    ]
    
    
    //头部
    
    //  头像
    var   imgportrait:UIImage!
    // 功能不实现
    lazy var   infoview:LLUerInfoView = {
        
        let   ainfoview = Bundle.main.loadNibNamed("LLUerInfoView", owner: nil, options: nil)?.first  as!LLUerInfoView
        return  ainfoview
    }()
    
    
    lazy var   headview:UIView = {
        return   UIView()
    }()
    //
    lazy var   btnlogin:LLBaseButton = {
        let  btn = LLBaseButton()
       
        btn.setTitle("登录", for: .normal)
        btn.addTarget(self, action: #selector(LLAcountViewController.login), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return  btn
    }()
    //
    lazy var   btnregister:LLBaseButton = {
        let  abtn = LLBaseButton()
       
        abtn.setTitle("注册", for: .normal)
        abtn.addTarget(self, action: #selector(LLAcountViewController.register), for: .touchUpInside)
        abtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return  abtn
    }()
    
    //头像
    lazy  var  portraitimg:UIImageView = {
        let  img = UIImageView()
       
        img.isUserInteractionEnabled  =  true
        let  atapgesture = UITapGestureRecognizer(target: self, action: #selector(LLAcountViewController.changeportrait))
        img.clipsToBounds = true
        img.layer.cornerRadius = 30
        
        img.addGestureRecognizer(atapgesture)
        return  img
    }()
    //退出按钮
    lazy   var   btnlogout:LLBaseButton = {
        
        let  logout  = LLBaseButton()
        logout.setTitle("退出", for: .normal)
        logout.titleLabel?.font = UIFont.systemFont(ofSize: 11)
      
        logout.addTarget(self, action: #selector(LLAcountViewController.logout), for: .touchUpInside)
        
        BmobUser.logout()
        
        return  logout
    }()
    
    //下方列表
    
    lazy var   tableview:LLBaseTableView = {
        let   listtable = LLBaseTableView(frame: CGRect.zero,style: .plain)
        
        return  listtable
        
        
    }()
    func   initalframe(){
        btnlogin.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.bottom.equalTo(-70)
            maker.left.equalTo((ScreenWidth - 200)/2.0)
            
        }
        infoview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            maker.height.equalTo(30)
            maker.bottom.equalTo(-60)
            maker.left.equalTo(0)
        }
        
        portraitimg.snp.makeConstraints { (maker) in
            maker.width.equalTo(60)
            maker.height.equalTo(60)
            maker.centerX.equalTo(headview)
            maker.top.equalTo(25)
        }
        btnregister.snp.makeConstraints { (maker) in
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.bottom.equalTo(-70)
            maker.right.equalTo(-(ScreenWidth - 200 )/2.0)
        }
        headview.snp.makeConstraints { (maker) in
            maker.top.equalTo(0)
            maker.width.equalTo(view)
            maker.height.equalTo(200)
        }
        btnlogout.snp.makeConstraints { (maker) in
            maker.centerX.equalTo(headview)
            maker.width.equalTo(80)
            maker.height.equalTo(30)
            maker.bottom.equalTo(-70)
            
        }
        tableview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            
            maker.height.equalTo(ScreenHeight  -  245)
            maker.top.equalTo(202)
        }
        infoview.snp.makeConstraints { (maker) in
            maker.width.equalTo(ScreenWidth)
            maker.left.equalTo(0)
            maker.height.equalTo(30)
            maker.top.equalTo(170)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(patternImage: UIImage(named:"background")!)
        navigationController?.delegate = self
        initialview()
        initalframe()
        updateview()
        //订阅
        NOTIfyCenter.addObserver(self, selector: #selector(LLAcountViewController.getnotify(_:)), name: NSNotification.Name(rawValue: notificationName), object: nil)
        
        NOTIfyCenter.addObserver(self, selector: #selector(LLAcountViewController.getnotify(_:)), name: NSNotification.Name(rawValue: notificationSelect), object: nil)
        
    }
    func animateTable(_ tableView:UITableView) {
        tableview.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 0.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        updateview()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTable(tableview)
    }
    
    // configheadview
    func updateview()  {
        //无用户
        let   auser = LLCurrentUser.currentuser.user
        var   porimg:UIImage!
        if  auser  != nil &&   (auser?.alreadysetportrait())!{
            let    imgpath = auser?.portrait
            porimg  =  UIImage(contentsOfFile: imgpath!)
        }
        else  if  auser == nil {
            porimg  =  UIImage(named: "default")
            
            
            
        }
        else{
            porimg  =  UIImage(named: (auser?.portrait)!)
        }
        if auser != nil {
            
            btnlogin.isHidden  =  true
            btnregister.isHidden = true
            btnlogout.isHidden = false
        }
        else{
            
            btnlogin.isHidden  =  false
            btnregister.isHidden = false
            btnlogout.isHidden = true
        }
        portraitimg.image =  porimg
        
        if    LLCurrentUser.currentuser.user != nil {
            infoview.lblwatched.text  = String(  LLCollectListManager.share.watcheditems.count)
            
            infoview.lblcollected.text =  String(  LLCollectListManager.share.collectionitems.count)
            
            
        }
        else{
            infoview.lblwatched.text  =   "未知"
            
            infoview.lblcollected.text =  "未知"

        }
        
        
    }
   
    func initialview(){
        navigationController?.navigationBar.isHidden = true
        view.addSubview(headview)
        
        headview.backgroundColor = UIColor.white
        
        headview.addSubview(btnlogin)
        headview.addSubview(btnregister)
        headview.addSubview(portraitimg)
        headview.addSubview(btnlogout)
        view.addSubview(infoview)
        view.addSubview(tableview)
        infoview.delegate = self
        tableview.delegate = self
        tableview.dataSource = self
        let cellNib = UINib(nibName: "LLAccoutCell", bundle: nil)
        tableview.register(cellNib, forCellReuseIdentifier: "cell")
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateview()
    }
    override func hiddenbar() -> Bool {
        return  true
    }
    
    func login()  {
        
        
        navigationController?.pushViewController(LLLoginViewController(), animated: true)
        
        
    }
    func     register(){
        navigationController?.pushViewController(LLRegisterViewController(), animated: true)
        
        
        
    }
    func  logout(){
        LLCurrentUser.currentuser.user.cleanuser()
//       cleancahe()
        //  主要是 更新的是 头部  以及 夜间模式的开关
        updateview()
        
    }
    // 改变头像
    func   changeportrait(){
        let   auser = LLCurrentUser.currentuser.user
        if auser == nil {
            
            _  = SweetAlert().showAlert("请先登录")
            return
        }
        
        
        
        
        weak   var  tmp = self
        //
        let   alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "相册", style: .default, handler: {(action) in
            if(tmp?.PhotoLibraryPermissions() == true){
                tmp?.sourceType = UIImagePickerControllerSourceType.photoLibrary
                tmp?.open()
            }else{
                _  = SweetAlert().showAlert("请到通用－>隐私设置允许访问相册")
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "相机", style: .default, handler: { (action) in
            if(tmp?.cameraPermissions() == true){
                tmp?.sourceType  = UIImagePickerControllerSourceType.camera
                
                tmp?.open()
            }else{
                _  = SweetAlert().showAlert("请到通用－>隐私设置允许访问相机")
                
                
            }
        }))
       
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    private    func  open(){
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true//true为拍照、选择完进入图片编辑模式
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion:nil)
    }
    //访问相机
    private  func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
        
    }
    //访问相册
    private  func PhotoLibraryPermissions() -> Bool {
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
    }
    //移除通知
    
    deinit {
        
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationName), object: nil)
        
        NOTIfyCenter.removeObserver(self, name: NSNotification.Name(rawValue: notificationSelect), object: nil)
        print("LLAcountViewController释放")
        
        
    }
    
    
}
extension  LLAcountViewController : UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate , UIImagePickerControllerDelegate ,LLUerInfoViewProDelegate{
    //  tableview 代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return  accoutlistdata.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let     arr = accoutlistdata[section]
        return  arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell = tableview.dequeueReusableCell(withIdentifier: "cell") as?  LLAccoutCell
        let  cells = accoutlistdata[indexPath.section]
        let  info = cells[indexPath.row]
        if   cell ==  nil {
            
            cell = LLAccoutCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.backgroundColor = UIColor.clear
        //        cell?.textLabel?.text = accoutlistdata[indexPath.row]
        cell?.model = info
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return   15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if   indexPath.section == 2  && indexPath.row == 0{
            return
        }
        let  cells = accoutlistdata[indexPath.section]
        let  info = cells[indexPath.row]
        let   selectnname = info["info"]
        
        
        let anotificationName = Notification.Name(rawValue: notificationName)
        let obj = trantonotifyname(selectnname!)
        NotificationCenter.default.post(name: anotificationName, object: obj,
                                        userInfo:nil)
        
    }
    
    
    // 页面跳转回调用
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        updateview()
    }
    
    //  图片选择代理
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        
        
        // 拿到此图片 需要 存入本地
        var   userpath = userCachePath.appending("\(LLCurrentUser.currentuser.user.username)_por.png")
        let   imgdata = UIImageJPEGRepresentation(image, 0.5)
        //  写入时先将本地头像清理了
        if(FileManager.default.fileExists(atPath:userpath)){
            // 删除
            try! FileManager.default.removeItem(atPath: userpath)
        }
        do  {
            try imgdata?.write(to: URL(fileURLWithPath: userpath))
            //  需要重新归档
            _   =  LLCurrentUser.currentuser.user.changeportrait(path:userpath)
            _ = LLCurrentUser.currentuser.user.saveuser()
            
        }catch {
            //  将 path 至诚 空
            userpath = ""
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    //  看过 收藏  资料
    
    func  selectindexitem(index:Int){
        
        if   LLCurrentUser.currentuser.user == nil {
            _  = SweetAlert().showAlert("请先登录")
            
        }else{
        
            if  index == 2{
                let  ctr = LLPrivateInfoViewController()
                navigationController?.modalTransitionStyle = .partialCurl
                navigationController?.pushViewController(ctr, animated: true)
        }
            else  if  index == 1{
                let  ctr = LLCollectedViewController()
                navigationController?.pushViewController(ctr, animated: true)
        }
            else  if  index == 0{
                let  ctr = LLWatchedViewController()
                navigationController?.pushViewController(ctr, animated: true)
        }
        }
        
        
    }
    func  getnotify(_ notify:Notification){
        let  str  =  notify.object  as!  String
        switch str {
        case "我的消息":
            if   LLCurrentUser.currentuser.user == nil {
                _  = SweetAlert().showAlert("请先登录")
                
            }
            else{
                
                navigationController?.pushViewController(LLUserMsgViewController(), animated: true)
            }
            break;
        case "下载的视频":
            if   LLCurrentUser.currentuser.user == nil {
                _  = SweetAlert().showAlert("请先登录")
                
            }
            else{
                
                navigationController?.pushViewController(LLMovieDownViewController(), animated: true)
            }
            break;
        case "主题皮肤":
            if   LLCurrentUser.currentuser.user == nil {
                _  = SweetAlert().showAlert("请先登录")
                
            }
            else{
                
                navigationController?.pushViewController(LLThemeViewController(), animated: true)
            }
            break;
        case "猜你喜欢":
            if   LLCurrentUser.currentuser.user == nil {
                _  = SweetAlert().showAlert("请先登录")
                
            }
            else{
                
                if   LLCollectListManager.share.collectionitems.count >= 3 {
                
                
                    navigationController?.pushViewController(LLPrefrenceViewController(), animated: true)
                }
                else{
                    
                     _  = SweetAlert().showAlert("收集用户数据太少无法推荐")
                }
            }
            break;
        case "反馈意见":
            if   LLCurrentUser.currentuser.user == nil {
                _  = SweetAlert().showAlert("请先登录")

            }
            else{
            
               navigationController?.pushViewController(LLRevertViewController(), animated: true)
            }

            break;
        case "清理缓存":
            cleancahe()
            break;
        case "关于":
          
                navigationController?.pushViewController(LLAboutViewController(), animated: true)
            
            
            break;
         default:
            break
//               _  = SweetAlert().showAlert("nil")
        }
        
        
        
    }
    func   trantonotifyname(_ str:String) -> String{
        
        if  str == "我的消息"{
            
            return LLPOSTmsg
        }
        if  str == "下载的视频"{
            
            return LLPOSTDownList
        }
        if  str == "主题皮肤"{
            
            return LLPOSTSubstyle
        }
        if  str == "猜你喜欢"{
            
            return LLPOSTIntersting
        }
        if  str == "反馈意见"{
            
            return LLPOSTRevert
        }
        if  str == "清理缓存"{
            
            return LLPOSTClean
        }
        if  str == "关于"{
            
            return LLPOSTAbout
        }
        return   ""
        
    }
    
    
    
}
