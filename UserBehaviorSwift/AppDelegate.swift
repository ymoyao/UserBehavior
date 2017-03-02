//
//  AppDelegate.swift
//  UserBehaviorSwift
//
//  Created by MasterFly on 2017/3/2.
//  Copyright © 2017年 MasterFly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let vc = AViewController()
        let nav = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        
        //友盟
        UMAnalyticsConfig.sharedInstance().appKey = "58b7de3e3eae2534550010e1"
        UMAnalyticsConfig.sharedInstance().channelId = "App Store";
        
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        MobClick.setAppVersion(version as! String!)                      //版本
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())//应用配置
        
        
        //Asperts 
        
        //进入页面
        let viewWillAppearBlock:@convention(block) (AspectInfo)-> Void = { aspectInfo in
            
            //获得实例
            let instance = aspectInfo.instance() as? RootViewController
            guard instance != nil else {
                return
            }
            
            //实例转 格式化 string
            let className = String.init(reflecting: instance)
            let arr = className.components(separatedBy: ".")
            guard arr.count > 1 else {
                return
            }
            
            //最终类名
            let finalClassName = arr[1].components(separatedBy: ":").first! as String
            
            //标题
            let title = instance?.title != nil ? instance?.title : "unknown"
            
            
            //最终使用 ： type + 类名 + 标题 ，用“／”来分割
            let logFlag = "pageIn/" + finalClassName + "/" + title!
            MobClick.beginLogPageView(logFlag)
            print(logFlag)
        }
        
        //离开页面
        let viewWillDisappearBlock:@convention(block) (AspectInfo)-> Void = { aspectInfo in
            
            let instance = aspectInfo.instance() as? RootViewController
            guard instance != nil else {
                return
            }
            
            let className = String.init(reflecting: instance)
            let arr = className.components(separatedBy: ".")
            guard arr.count > 1 else {
                return
            }
            
            let finalClassName = arr[1].components(separatedBy: ":").first! as String
            let title = instance?.title != nil ? instance?.title : "unknown"
            
            
            let logFlag = "pageOut/" + finalClassName + "/" + title!
            MobClick.endLogPageView(logFlag)
            print(logFlag)
        }
        
        
        //按钮
        let touchesBeganBlock:@convention(block) (AspectInfo)-> Void = { aspectInfo in
            let instance = aspectInfo.instance() as? RootButton
            
            guard instance != nil else {
                return
            }
            
            let className = String.init(reflecting: instance?.allTargets.first)
            let arr = className.components(separatedBy: ".")
            guard arr.count > 1 else {
                return
            }
            
            let finalClassName = arr[1].components(separatedBy: ":").first! as String
            
            let title = instance?.titleLabel?.text != nil ? instance?.titleLabel?.text : "unknown"

            let logFlag = "event/" + finalClassName + "/" + title!
            
            let path = Bundle.main.path(forResource: "UserBehavior", ofType: "plist")
            let dict = NSDictionary.init(contentsOfFile: path!)
            let id = dict?.object(forKey: logFlag) as? String
            guard id != nil else {
                return
            }
            
            MobClick.event(id, label: logFlag)

            print(logFlag)
        }
        
        //转换
        let viewWillAppearBlockWrapped: AnyObject = unsafeBitCast(viewWillAppearBlock, to: AnyObject.self)
        let viewWillDisappearBlockWrapped: AnyObject = unsafeBitCast(viewWillDisappearBlock, to: AnyObject.self)
        let touchesBeganBlockWrapped: AnyObject = unsafeBitCast(touchesBeganBlock, to: AnyObject.self)

        //最终hook住对应的函数
        do {
            try RootViewController.aspect_hook(#selector(RootViewController.viewWillAppear(_:)), with: AspectOptions.positionBefore, usingBlock: viewWillAppearBlockWrapped)
            try RootViewController.aspect_hook(#selector(RootViewController.viewWillDisappear(_:)), with: AspectOptions.positionBefore, usingBlock: viewWillDisappearBlockWrapped)
            try RootButton.aspect_hook(#selector(RootButton.touchesBegan(_:with:)), with: AspectOptions.positionBefore, usingBlock: touchesBeganBlockWrapped)
        }
        catch {
            print(error)
        }
        

   
        
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


}

