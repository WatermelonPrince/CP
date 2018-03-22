//
//  UserService.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class UserService: BaseService {
    var tempToken: String?;
    
    func login(mobile: String, password: String) {
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["password"] = password;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.LOGIN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            self.setLoginToken(loginToken);
            ViewUtil.dismissToast();
            self.onCompleteSuccess();
        }
    }
    
    func wxLogin(code: String) {
        var parameters = Dictionary<String, String>();
        parameters["code"] = code;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.WX_LOGIN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            self.setLoginToken(loginToken);
            ViewUtil.dismissToast();
            self.onCompleteSuccess();
        }
    }
    
    func getUser() {
        if (LotteryUtil.token() == nil) {
            self.onCompleteFail();
            return;
        }
        var parameters = Dictionary<String, String>();
        parameters["token"] = LotteryUtil.token();
        self.post(HTTPConstants.LOGIN_BY_TOKEN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            self.setLoginToken(loginToken);
            self.onCompleteSuccess();
        }
    }
    
    func register(mobile: String, password: String, smsCode: String, from: String?) {
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["password"] = password;
        parameters["smsCode"] = smsCode;
        parameters["from"] = from;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.REGISTER, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            self.setLoginToken(loginToken);
            ViewUtil.showToast(text: "注册成功");
            self.onCompleteSuccess();
        }
    }
    
    func forgetPassword(mobile: String, password: String, smsCode: String) {
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["password"] = password;
        parameters["smsCode"] = smsCode;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.FORGET_PASSWORD, encryptParameters: parameters) { (json) in
            ViewUtil.showToast(text: "请重新登录");
            self.onCompleteSuccess();
        }
    }
    
    func changePassword(password: String) {
        var parameters = Dictionary<String, String>();
        parameters["password"] = password;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.CHANGE_PASSWORD, encryptParameters: parameters) { (json) in
            ViewUtil.showToast(text: "密码修改成功");
            self.onCompleteSuccess();
        }
    }
    
    func setLoginToken(_ loginToken: LoginToken?) {
        if (loginToken != nil) {
            LotteryUtil.saveToken(token: loginToken?.token);
            LotteryUtil.saveUser(user: loginToken?.user);
            //用户关联推送
            GeTuiSdk.bindAlias(LotteryUtil.user()?.userId, andSequenceNum: LotteryUtil.user()?.userId)
            MobClick.profileSignIn(withPUID: LotteryUtil.user()?.userId)

        }
    }
    
    func getTempToken() {
        var parameters = Dictionary<String,String>();
        parameters["token"] = LotteryUtil.token();
        self.post(HTTPConstants.GET_TEMP_TOKEN, encryptParameters: parameters, success: { (json) in
            let tempToken = json["tempToken"].object as? String;
            self.tempToken = tempToken;
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            //失败
            self.onCompleteFail();
            return true;
        }
    }
    
    func commitInfo(name: String) {
        var parameters = Dictionary<String, Any>();
        parameters["name"] = name;
        self.post(HTTPConstants.COMMIT_INFO, parameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
    }

}
