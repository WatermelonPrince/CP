//
//  AppDelegate.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate, XHLaunchAdDelegate,GeTuiSdkDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    static var context: AppContext!;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //初始化界面
        self.window = UIWindow(frame: UIScreen.main.bounds);
//        let openTimes = CommonUtil.getStorageVariable(forKey: "save_openAppTimes");
//        if (openTimes == nil) {
            //欢迎页
//            self.window?.rootViewController = LotteryGuideViewController();
//            //默认开启摇一摇
//            LotteryUtil.saveIsEnabledShakeAction(isOn: true);

//        } else {
            //开屏广告
            LaunchAdService().getAd();
            XHLaunchAd.setWaitDataDuration(1);
            self.perform(#selector(showLaunchAd), with: self, afterDelay: 1);
            AppDelegate.applicationInitial(launchOptions: launchOptions);
            self.window?.rootViewController = LotteryTabBarViewController();
//        }
        self.window?.makeKeyAndVisible();
        
        //处理PushNotification
        
        // [ GTSdk ]：自定义渠道
        GeTuiSdk.setChannelId("APPStore");
        
        // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
        //MARK:模拟器情况下 不启动个推SDK,原因会偶尔崩溃,真机无问题!!!
        
        if Platform.isSimulator == false {
            GeTuiSdk.start(withAppId: kGtAppId, appKey: kGtAppKey, appSecret: kGtAppSecret, delegate: self)

        }
      
        
        
        // 注册APNs - custom method - 开发者自定义的方法
        self.registerRemoteNotification();
        //友盟统计
        self.UMSDKInit()
        
        return true;
    }
    
    //MARK:友盟统计初始参数
    func UMSDKInit(){

        UMAnalyticsConfig.sharedInstance().appKey = uMengKey
        UMAnalyticsConfig.sharedInstance().channelId = "AppStore"
        UMAnalyticsConfig.sharedInstance().ePolicy=BATCH;
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        MobClick.setAppVersion(CommonUtil.currentProductVersion())

        
        MobClick.setLogEnabled(true)
    }
    
    // MARK: - 用户通知(推送) _自定义方法
    
    /** 注册用户通知(推送) */
    func registerRemoteNotification() {
        /*
         警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
         */
        
        /*
         警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
         以下为演示代码，仅供参考，详细说明请参考苹果开发者文档，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken。
         */
        
        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
        if systemVer >= 10.0 {
            if #available(iOS 10.0, *) {
                let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
                center.delegate = self
                center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        print("注册通知成功") //点击允许
                    } else {
                        print("注册通知失败") //点击不允许
                    }
                })
                
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if #available(iOS 8.0, *) {
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            };
        }else if systemVer >= 8.0 {
            if #available(iOS 8.0, *) {
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)
                
                UIApplication.shared.registerForRemoteNotifications()
            }
        }else {
            if #available(iOS 7.0, *) {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        }
    }
    
    static func applicationInitial(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        //初始化路由
        HostRouter.registerRoutes();
        
        //初始化App
        AppDelegate.context = AppContext();
        AppDelegate.context.initial();
        
        //注册微信
        WXApi.registerApp(WECHAT_ID);
        //注册GrowingIO
//        Growing.start(withAccountId: GROWINGIO_ID);
//        Growing.setEnableLog(false);
        //注册Bugly
        Bugly.start(withAppId: BUGLY_ID);
        //初始化JPush
       
        //弹出评价窗口
        CommonUtil.showStoreReviewController();
    }
    
    func showLaunchAd() {
        //开屏广告页
        let imageAdConfig = LotteryLaunchAdConfiguration();
        XHLaunchAd.imageAd(with: imageAdConfig, delegate: self);
    }
    
    func xhLaunchAd(_ launchAd: XHLaunchAd, clickAndOpenURLString openURLString: String) {
        LotteryRoutes.routeURLString(openURLString);
    }

    // MARK: - 远程通知(推送)回调
    
    /** 远程通知注册成功委托 */
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let deviceToken_ns = NSData.init(data: deviceToken);    // 转换成NSData类型
        var token = deviceToken_ns.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>"));
        token = token.replacingOccurrences(of: " ", with: "")
        
        // [ GTSdk ]：向个推服务器注册deviceToken
        GeTuiSdk.registerDeviceToken(token);
        
        NSLog("\n>>>[DeviceToken Success]:%@\n\n",token);
    }
    /** 远程通知注册失败委托 */
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("\n>>>[DeviceToken Error]:%@\n\n",error.localizedDescription);
    }
    
    // MARK: - APP运行中接收到通知(推送)处理 - iOS 10 以下
    
    /** APP已经接收到“远程”通知(推送) - (App运行在后台) */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        application.applicationIconBadgeNumber = 0;        // 标签
        
        NSLog("\n>>>[Receive RemoteNotification]:%@\n\n",userInfo);
    }

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //Required, iOS 7 Support
        self.handlePushNotificationAction(userInfo: userInfo);
        // [ GTSdk ]：将收到的APNs信息传给个推统计
        GeTuiSdk.handleRemoteNotification(userInfo);
        NSLog("\n>>>[Receive RemoteNotification]:%@\n\n",userInfo);

        completionHandler(UIBackgroundFetchResult.newData);
    }
    
    
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("willPresentNotification: %@",notification.request.content.userInfo);
        
        completionHandler([.badge,.sound,.alert]);
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("didReceiveNotificationResponse: %@",response.notification.request.content.userInfo);
        let userInfo = response.notification.request.content.userInfo;
        
        self.handlePushNotificationAction(userInfo: userInfo);
        
        // [ GTSdk ]：将收到的APNs信息传给个推统计
        GeTuiSdk.handleRemoteNotification(response.notification.request.content.userInfo);
        
        completionHandler();
    }
    
    
    
    func handlePushNotificationAction(userInfo: [AnyHashable : Any]) {
        let aps = userInfo["aps"] as? Dictionary<String, Any>;
        let category = aps?["category"] as? String;
        if (category != nil) {
            LotteryRoutes.routeURLString(category!);
        }
    }
    
    // MARK: - GeTuiSdkDelegate
    
    /** SDK启动成功返回cid */
    func geTuiSdkDidRegisterClient(_ clientId: String!) {
        // [4-EXT-1]: 个推SDK已注册，返回clientId
        NSLog("\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    }
    
    /** SDK遇到错误回调 */
    func geTuiSdkDidOccurError(_ error: Error!) {
        // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
        NSLog("\n>>>[GeTuiSdk error]:%@\n\n", error.localizedDescription);
    }
    
    /** SDK收到sendMessage消息回调 */
    func geTuiSdkDidSendMessage(_ messageId: String!, result: Int32) {
        // [4-EXT]:发送上行消息结果反馈
        let msg:String = "sendmessage=\(messageId),result=\(result)";
        NSLog("\n>>>[GeTuiSdk DidSendMessage]:%@\n\n",msg);
    }
    
    func geTuiSdkDidReceivePayloadData(_ payloadData: Data!, andTaskId taskId: String!, andMsgId msgId: String!, andOffLine offLine: Bool, fromGtAppId appId: String!) {
        
        var payloadMsg = "";
        if((payloadData) != nil) {
            payloadMsg = String.init(data: payloadData, encoding: String.Encoding.utf8)!;
        }
        
        let msg:String = "Receive Payload: \(payloadMsg), taskId:\(taskId), messageId:\(msgId)";
        
        NSLog("\n>>>[GeTuiSdk DidReceivePayload]:%@\n\n",msg);
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "ShortcutIdentifier.result":
            let tabBarViewController = LotteryTabBarViewController();
            self.window?.rootViewController = tabBarViewController;
            tabBarViewController.selectedIndex = 1;
            break;
        default:
            break;
        }
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if (url.absoluteString.hasPrefix("wx")) {
            return WXApi.handleOpen(url, delegate: self);
        }
        
//        if (Growing.handle(url)) {
//            return true;
//        }
        
        return false;
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if (url.absoluteString.hasPrefix("wx")) {
            return WXApi.handleOpen(url, delegate: self);
        }
        
//        if (Growing.handle(url)) {
//            return true;
//        }
        
        return false;
    }
    
    func onReq(_ req: BaseReq!) {

    }
    
    func onResp(_ resp: BaseResp!) {
        if (resp.isKind(of: SendAuthResp.classForCoder()) == true) {
            let authResp = resp as! SendAuthResp;
            if (authResp.errCode == 0) {
                let dict = ["code" : authResp.code];
                let code = dict["code"] as? String;
                if (code != nil) {
                    //微信登录成功后 发送登录成功后 注册成为通知中心消息
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "WxLoginNotification"), object: self, userInfo: ["code": code!]));
                } else {
                    ViewUtil.showToast(text: "登录失败");
                }
            }
        }
        
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
        //清除badges
        GeTuiSdk.setBadge(0) //同步本地角标值到服务器
        UIApplication.shared.applicationIconBadgeNumber = 0;
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

