//
//  MobileLoginViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//
//手机号验证登录
import UIKit
class MobileBaseBottomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.setTitleColor(CommonUtil.colorWithAlpha(color: COLOR_BLUE, alpha: 0.5), for: .highlighted);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MobileLoginViewController: LotteryBaseScrollViewController, ServiceDelegate {
    var mobileView: MobileTextFieldView!;
    var passwordView: PasswordTextFieldView!;
    var loginButton: LotteryBaseButton!;
    var registerButton: MobileBaseBottomButton!;
    var forgetButton: MobileBaseBottomButton!;
    
    var userService: UserService!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手机号登陆";
        
        //手机号
        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.scrollView.addSubview(self.mobileView);
        
        //密码
        self.passwordView = PasswordTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY + 1, width: self.view.frame.width, height: self.mobileView.frame.height));
        self.scrollView.addSubview(self.passwordView);
        
        //登陆
        self.loginButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.passwordView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.mobileView.frame.height));
        self.loginButton.setTitle("登陆", for: .normal);
        self.scrollView.addSubview(self.loginButton);
        self.loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside);
        
        //现在注册
        self.registerButton = MobileBaseBottomButton(frame: CGRect(x: self.loginButton.frame.minX, y: self.loginButton.frame.maxY + 20, width: 100, height: self.mobileView.frame.height - 10));
        self.registerButton.setTitle("现在注册>>", for: .normal);
        self.scrollView.addSubview(self.registerButton);
        self.registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside);
        
        //忘记密码
        self.forgetButton = MobileBaseBottomButton(frame: CGRect(x: self.view.frame.width - self.registerButton.frame.minX - self.registerButton.frame.width, y: self.registerButton.frame.minY, width: self.registerButton.frame.width, height: self.registerButton.frame.height));
        self.forgetButton.setTitle("忘记密码?", for: .normal);
        self.scrollView.addSubview(self.forgetButton);
        self.forgetButton.addTarget(self, action: #selector(forgetAction), for: .touchUpInside);
        
        self.userService = UserService(delegate: self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.dismiss(animated: true, completion: nil);
        LotteryUtil.saveIsWechatLogin(isWechatLogin: false);
    }
//登录/user/login
    func loginAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入密码");
        } else {
            self.userService.login(mobile: self.mobileView.textField.text!, password: self.passwordView.textField.text!);
            self.mobileView.textField.resignFirstResponder();
            self.passwordView.textField.resignFirstResponder();
        }
    }
    
    func registerAction() {
        let vc = MobileRegisterViewController();
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func forgetAction() {
        let vc = ForgetPasswordViewController();
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
}
