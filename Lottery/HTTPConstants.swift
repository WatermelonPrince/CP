//
//  HTTPConstants.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HTTPConstants: NSObject {
    
    /**   
     * Host
     */
//    static let HOST = "https://www.huhad.com";
    
    /**
     * TestHost
     */
//      static let HOST = "http://test.huhad.com";
    
    
    
    /**
     * Dev
     */
    static let HOST = "http://192.168.0.108:8080";
    
    /**
     * WapHost
     */
    static let WAP_HOST = HOST + "/m";
    
    
    /**
     * HELP
     */
    static let HELP = "/help";
    static let HELP_GAME = WAP_HOST + HELP + "/game";
    static let HELP_DANTUO = WAP_HOST + HELP + "/dantuo";
    static let HELP_BANKCARD = WAP_HOST + HELP + "/bankCard";
    
    /**
     * Agreement/About
     */
    static let AGREEMENT = WAP_HOST + "/agreement";
    static let ABOUT = WAP_HOST + "/about";
    static let ARTICLE = WAP_HOST + "/article/detail?articleId="
    
    /**
     * ApiHost
     */
    static let API_HOST = HOST + "/i";
    
    /**
     * APP
     */
    static let INITIAL = API_HOST + "/common/initial";

    /**
     * User
     */
    static let SEND_SMS = API_HOST + "/sms/send";
    static let SEND_VOICE_SMS = API_HOST + "/sms/voiceSend";
    static let LOGIN = API_HOST + "/user/login";
    static let LOGIN_BY_TOKEN = API_HOST + "/user/tokenLogin";
    static let REGISTER = API_HOST + "/user/register";
    static let FORGET_PASSWORD = API_HOST + "/user/password/forget";
    static let CHANGE_PASSWORD = API_HOST + "/user/password/change";
    static let GET_TEMP_TOKEN = API_HOST + "/user/getTempToken";
    static let WX_LOGIN = API_HOST + "/user/weixinLogin";
    static let AVATAR_COMMIT = API_HOST + "/user/avatar";
    static let COMMIT_INFO = API_HOST + "/user/commitInfo";
    
    /**
     * Splash
     */
    static let SPLASH = API_HOST + "/index/splash";
    
    /**
     * Home
     */
    static let HOME = API_HOST + "/index/home";
    /**
     * News
     */
    static let NEWS = HOST + "/article/list.do"
    /**
     * Notice
     */
    static let NOTICE = API_HOST + "/index/notice";
    
    /**
     * Periods
     */
    static let PERIODS = API_HOST + "/index/periods";
    
    /**
     * BET
     */
    static let BET = API_HOST + "/bet";
    
    /**
     * ORDER
     */
    static let ORDER_ADD = API_HOST + "/order/add";
    static let ORDER_LIST = API_HOST + "/order/list";
    static let ORDER_DETAIL = API_HOST + "/order/detail";
    static let ORDER_CONTINUE_PAY = API_HOST + "/order/continueToPay";
    static let ORDER_CHECK_ORDER_PAY = API_HOST + "/order/checkOrderPay";
    
    /**
     * TICKET
     */
    static let TICKET_DETAIL = API_HOST + "/ticket/detail";
    
    /**
     * FOLLOW
     */
    static let FOLLOW_BUY = API_HOST + "/follow/followBuy";
    static let FOLLOW_LIST = API_HOST + "/follow/list";
    static let FOLLOW_DETAIL = API_HOST + "/follow/detail";
    
    /**
     * ACCOUNT
     */
    static let BALANCE = API_HOST + "/account/balance";
    static let BILL_LIST = API_HOST + "/account/billList";
    static let QUERY_BANK_CARD = API_HOST + "/account/queryBankCard";
    static let BIND_BANK_CARD = API_HOST + "/account/bindBankCard";
    static let QUERY_IDENTITY = API_HOST + "/account/queryIdentity";
    static let VERIFY_IDENTITY = API_HOST + "/account/verifyIdentity";
    static let WITHDRAW = API_HOST + "/account/withdraw";
    static let RED_PACKET_LIST = API_HOST + "/account/redPacketList";
    static let CHARGE = API_HOST + "/account/charge";
    static let CHECK_CHARGE_PAY = API_HOST + "/account/checkChargePay";
    static let FEEDBACK = API_HOST + "/common/feedback/commit";
    
    /**
     * PAY
     */
    static let PREPAY = API_HOST + "/pay/prepay";
}
