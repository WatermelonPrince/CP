//
//  SmsService.swift
//  Lottery
//
//  Created by DTY on 2017/4/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SmsService: BaseService {
    static let TYPE_REGISTER = "register";
    static let TYPE_RESETPASSWD = "resetpasswd";
    
    func sendSms(mobile: String) {
        self.sendSms(mobile: mobile, type: nil);
    }
    
    func sendSms(mobile: String, type: String?) {
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["type"] = type;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.SEND_SMS, encryptParameters: parameters, success: { (json) in
            ViewUtil.showToast(text: "验证码已发送");
        })
    }
    
    func sendVoiceSms(mobile: String, type: String) {
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["type"] = type;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.SEND_VOICE_SMS, encryptParameters: parameters, success: { (json) in
            ViewUtil.showToast(text: "请注意接听语音验证码");
        })
    }

}
