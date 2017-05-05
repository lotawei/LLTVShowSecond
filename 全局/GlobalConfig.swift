//
//  GlobalConfig.swift
//  LLTVShow
//
//  Created by lotawei on 16/11/27.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit
//  

//  用语测试播放的借口地址
public let urls = ["http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
            "http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
            "http://baobab.wdjcdn.com/14525705791193.mp4",
            "http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
            "http://baobab.wdjcdn.com/1455968234865481297704.mp4",
            "http://baobab.wdjcdn.com/1455782903700jy.mp4",
            "http://baobab.wdjcdn.com/14564977406580.mp4",
            "http://baobab.wdjcdn.com/1456316686552The.mp4",
            "http://baobab.wdjcdn.com/1456480115661mtl.mp4",
            "http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
            "http://baobab.wdjcdn.com/1455614108256t(2).mp4",
            "http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
            "http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
            "http://baobab.wdjcdn.com/1456734464766B(13).mp4",
            "http://baobab.wdjcdn.com/1456653443902B.mp4",
            "http://baobab.wdjcdn.com/1456231710844S(24).mp4"]



let  tvurl="https://route.showapi.com/951-1?showapi_appid=32615&showapi_timestamp=20170224154502&showapi_sign=e80620ed9e23a51d1223dcca7032a9f9"


// open电视猫
let  opentvurl  = "http://open.moretv.com.cn/moviesite"
//屏幕宽高度  尺寸常用
let kItemMargin : CGFloat = 10
let kHeaderViewH : CGFloat = 50
let kNormalItemW = (ScreenWidth - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let NormalCellID = "NormalCellID"
let SearchCellID = "SearchCellID"
let HeaderViewID = "HeaderViewID"

let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 49
var   ScreenWidth = UIScreen.main.bounds.size.width
var   ScreenHeight = UIScreen.main.bounds.size.height
//云数据库appkey
let   bmobappkey  = "6ddcdd50e7d7e32e67aec881b8585e4b"

//全局主题变化的通知
let   StyleNotifyChange = "StyleNotifyChange"

//获取app版本号及 ios 版本号
let infoDictionary = Bundle.main.infoDictionary
let appDisplayName: AnyObject? = infoDictionary!["CFBundleDisplayName"] as AnyObject?
let majorVersion : AnyObject? = infoDictionary! ["CFBundleShortVersionString"] as AnyObject?
let minorVersion : AnyObject? = infoDictionary! ["CFBundleVersion"] as AnyObject?
let appversion = majorVersion as! String
let iosversion : NSString = UIDevice.current.systemVersion as NSString   //ios 版本
let identifierNumber = UIDevice.current.identifierForVendor   //设备 udid
let systemName = UIDevice.current.systemName   //设备名称
let model = UIDevice.current.model   //设备型号
let localizedModel = UIDevice.current.localizedModel   //设备区域化型号


//整个app颜色基调
let   normalcolor:UIColor = UIColor.white

//黑夜模
let   darkcolor:UIColor = UIColor(red: 175.0/255.0, green: 177.0/255.0, blue: 170.0/255.0, alpha: 0.5)
//护眼模式
let   eyecolor:UIColor = UIColor(red:228.0/255.0, green: 233.0/255.0, blue: 237.0/255.0, alpha: 1.0)

//橙底
let   orcolor:UIColor =   UIColor(red: 179.0/255.0, green:140.0/255.0, blue: 64.0/255.0, alpha: 0.8)
let  tablelightcolor  =   UIColor.init(patternImage: UIImage(named:"img_light")!)
let   tablebackcolor = UIColor.init(patternImage: UIImage(named:"img_dark")!)
let   tableeyecolor = UIColor.init(patternImage: UIImage(named:"img_eyepro")!)

//按钮 颜色
var   btncolor:UIColor = UIColor(red: 200.0/255.0, green:250.0/255.0, blue: 253.0/255.0, alpha: 0.5)
//字体颜色
var   fontcolor:UIColor =  UIColor(red: 171.0/255.0, green:129.0/255.0, blue: 59.0/255.0, alpha: 0.8)

var    eyetextcolor:UIColor =  UIColor(red: 131.0/255.0, green:175.0/255.0, blue: 155.0/255.0, alpha: 0.5)
let   collectionbackcolor = UIColor(red: 0.0/255.0, green:0.0/255.0, blue: 0.0/255.0, alpha: 0.2)



//用户存储路经
 let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first!)/user.data"
 let searchpath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first!)/history.data"
//用户缓存路径 包括 头像图片资源 和 收藏影视 路径
 let userCachePath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/"

//


//列表 中 的通知  object  发的字符串

let   LLPOSTmsg = "我的消息"
let   LLPOSTDownList =  "下载的视频"
let   LLPOSTIntersting = "猜你喜欢"
let   LLPOSTSubstyle = "主题皮肤"
let   LLPOSDarkStyle = "夜间模式"
let   LLPOSEyeStyle = "护眼模式"
let   LLPOSLightStyle = "正常模式"
let   LLPOSTRevert = "反馈意见"
let   LLPOSTClean = "清理缓存"
let   LLPOSTAbout = "关于"
//

// 制定通知

let notificationName =  "notifystyle"
let notificationSelect =  "notifyselect"
let   NOTIfyCenter = NotificationCenter.default

//




