//
//  LotteryLoginViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//


//登录页面
import UIKit

class LotteryLoginViewController: LotteryBaseScrollViewController, ServiceDelegate {
    var loginView: LotteryLoginView!;
    var userService: UserService!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录";
        
        //NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancelAction));
        
        //LoginView
        self.loginView = LotteryLoginView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height));
        self.scrollView.addSubview(self.loginView);
        
        self.loginView.mobileLoginButton.addTarget(self, action: #selector(mobileLoginAction), for: .touchUpInside);
        self.loginView.wechatLoginButton.addTarget(self, action: #selector(wechatLoginAction), for: .touchUpInside);
        //未安装微信不显示微信登录方式
        self.loginView.wechatLoginButton.isHidden = !WXApi.isWXAppInstalled();
        
        //Initial
        self.initialApp();
        
        self.userService = UserService(delegate: self);
        
        NotificationCenter.default.addObserver(self, selector: #selector(wxLoginNotification), name: NSNotification.Name(rawValue: "WxLoginNotification"), object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func cancelAction() {
        self.dismiss(animated: true, completion: nil);
    }
    
    func mobileLoginAction() {
        if (LotteryUtil.appKey() != nil) {
           self.pushViewController(viewController: MobileLoginViewController());
        } else {
            self.initialApp();
        }
    }
    
    func wechatLoginAction() {
        
        if (LotteryUtil.appKey() != nil) {
            let req = SendAuthReq();
            req.scope = "snsapi_userinfo,snsapi_base";
            req.state = "0744";
            WXApi.send(req);
        } else {
            self.initialApp();
        }
    }
    
    func wxLoginNotification(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String : Any];
        let code = userInfo["code"] as! String;
        self.userService.wxLogin(code: code);
    }
    
    func onCompleteSuccess(service: BaseService) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.dismiss(animated: true, completion: nil);
        LotteryUtil.saveIsWechatLogin(isWechatLogin: true);
    }
    
    func initialApp() {
        AppDelegate.context.initial();
    }
    
    
}
