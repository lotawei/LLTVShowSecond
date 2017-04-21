//
//  AppDelegate.swift
//  LLTVShow
//
//  Created by lotawei on 16/11/27.
//  Copyright © 2016年 lotawei. All rights reserved.
//  //为避免用户注册登录的情况 直接出现首页 当出现收藏,推荐的时候才提示是否需要登录
// qq  appid  1106036217   appkey O9SSv5RKmlTVd3Pg
//  share  app ID 18263c6d92c9a  sceret 95e0641eb6ed91a5a5a1e86ae12fd5e6
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(userAccountPath)
        //  注册bmob的使用
        Bmob.register(withAppKey: bmobappkey)
        //  注册社交分享
        registershare()
//        ShareSDK.registerApp("95e0641eb6ed91a5a5a1e86ae12fd5e6", activePlatforms: <#T##[Any]!#>, onImport: <#T##SSDKImportHandler!##SSDKImportHandler!##(SSDKPlatformType) -> Void#>, onConfiguration: <#T##SSDKConfigurationHandler!##SSDKConfigurationHandler!##(SSDKPlatformType, NSMutableDictionary?) -> Void#>)
        
        
        
        let   winfr = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        window = UIWindow.init(frame: winfr)
       let locuser = LLCurrentUser.currentuser.user ?? nil
            //  分权限管理的话   是管理员 直有一个界面
        if  locuser != nil && locuser?.usertype.rawValue == Usertype.admin.rawValue {
                       let  nav = BaseNaVgationController(rootViewController: LLAdminViewController())
                         window?.rootViewController = nav
                UIApplication.shared.delegate?.window??.makeKeyAndVisible()
            }
        else{
                
                UIApplication.shared.delegate?.window??.rootViewController  = LLMainTabarController()
                UIApplication.shared.delegate?.window??.makeKeyAndVisible()
            }
            
        

      
    
        
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func   registershare(){
        ShareSDK.registerApp("18263c6d92c9a", activePlatforms: [SSDKPlatformType.typeSinaWeibo.rawValue,
                                                                SSDKPlatformType.typeTencentWeibo.rawValue,
                                                                SSDKPlatformType.typeFacebook.rawValue,
                                                                SSDKPlatformType.typeWechat.rawValue,
                                                                SSDKPlatformType.typeQQ.rawValue], onImport: {(platform : SSDKPlatformType) -> Void in
                                                                    
                                                                    switch platform{
                                                                        
                                                                  
                                                                        
                                                                    case SSDKPlatformType.typeQQ:
                                                                        ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                                                                    default:
                                                                        break
                                                                    }
        }) { (platform, appInfo) in
            switch platform {
                
            case SSDKPlatformType.typeQQ:
                //设置QQ应用信息
                appInfo?.ssdkSetupQQ(byAppId: "1106036217", appKey: "95e0641eb6ed91a5a5a1e86ae12fd5e6", authType: SSDKAuthTypeBoth)
            default:
                break
                
            }
        }
        
           }

}

