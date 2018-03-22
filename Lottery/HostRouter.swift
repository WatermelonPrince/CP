//
//  HostRouter.swift
//  Lottery
//
//  Created by DTY on 17/2/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import Foundation

//注册添加的的一些路由信息，能根据url指向目标控制器，并控制目标控制器的初始化

class HostRouter{
    
    static let HOST = "honghongcai";
    static let JUMP_HOST = HOST + "://";
    static let LOGIN = "/login";
    static let PAY = "/pay";
    static let ARTICLELIST = "/articleList"
    
    static func registerRoutes() {
        
        LotteryRoutes.addRoute("http/*") { (param: [AnyHashable: Any]?) -> Bool in
            let parameters = param! as NSDictionary;
            let urlContent = ((parameters[kJLRouteURLKey] as! NSURL).absoluteString)!;
            
            let vc = LotteryWebViewController();
            vc.urlContent = urlContent;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LotteryRoutes.addRoute("https/*") { (param: [AnyHashable: Any]?) -> Bool in
            let parameters = param! as NSDictionary;
            let urlContent = ((parameters[kJLRouteURLKey] as! NSURL).absoluteString)!;
            
            let vc = LotteryWebViewController();
            vc.urlContent = urlContent;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LotteryRoutes.addRoute(LOGIN) { (param: [AnyHashable: Any]?) -> Bool in
            let vc = LotteryBaseNavigationController(rootViewController: LotteryLoginViewController());
            ViewUtil.keyViewController().present(vc, animated: true, completion: nil);
            return true;
        }
        
        LotteryRoutes.addRoute("/bet") { (param: [AnyHashable: Any]?) -> Bool in
            var vc = UIViewController();
            let gameId = param?["gameId"] as? Int;
            let gameEn = param?["gameEn"] as? String;
            let gameName = param?["gameName"] as? String;
            let rule = param?["rule"] as? String;
            if (gameEn != nil) {
                //ssq
                if (LotteryUtil.hasSuffix(content: gameEn!, suffix: "ssq")) {
                    let dict = LotteryUtil.selectionList(gameEn: gameEn!);
                    if (dict != nil) {
                        vc = SSQOrderViewController();
                    } else {
                        vc = SSQMainViewController();
                    }
                }
                
                //Dlt
                if (LotteryUtil.hasSuffix(content: gameEn!, suffix: "dlt")) {
                    let dict = LotteryUtil.selectionList(gameEn: gameEn!);
                    if (dict != nil) {
                        vc = DLTOrderViewController();
                    } else {
                        vc = DLTMainViewController();
                    }
        
                }
                
                
                //D11
                if (LotteryUtil.hasSuffix(content: gameEn!, suffix: "d11")) {
                    let dict = LotteryUtil.selectionList(gameEn: gameEn!);
                    if (dict != nil) {
                        vc = D11OrderViewController();
                    } else {
                        vc = D11MainViewController();
                    }
                    
                }
            
                if (vc.isKind(of: LotteryOrderViewController.classForCoder())) {
                    (vc as! LotteryOrderViewController).gameEn = gameEn!;
                    if (gameId != nil) {
                       (vc as! LotteryOrderViewController).gameId = gameId!;
                    }
                    if (gameName != nil) {
                        (vc as! LotteryOrderViewController).gameName = gameName!;
                    }
                    if (gameEn != nil) {
                        (vc as! LotteryOrderViewController).gameEn = gameEn!;
                    }
                    ViewUtil.keyViewController().pushViewController(viewController: vc);
                } else if (vc.isKind(of: LotteryMainBaseViewController.classForCoder())) {
                    (vc as! LotteryMainBaseViewController).gameEn = gameEn!;
                    if (gameId != nil) {
                       (vc as! LotteryMainBaseViewController).gameId = gameId!;
                    }
                    if (gameName != nil) {
                        (vc as! LotteryMainBaseViewController).gameName = gameName!;
                    }
                    if (gameEn != nil) {
                        (vc as! LotteryMainBaseViewController).gameEn = gameEn!;
                    }
                    if (rule != nil){
                        (vc as! LotteryMainBaseViewController).rule = rule!;
                    }
                    ViewUtil.keyViewController().pushViewController(viewController: vc);
                }
            }
            
            return true;
        }
        
        LotteryRoutes.addRoute("/charge") { (param: [AnyHashable: Any]?) -> Bool in
            if (LotteryUtil.user() == nil) {
                LotteryRoutes.routeURLString(LOGIN);
                return true;
            }
            let vc = ChargeTableViewController();
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LotteryRoutes.addRoute("/identity") { (param: [AnyHashable: Any]?) -> Bool in
            if (LotteryUtil.user() == nil) {
                LotteryRoutes.routeURLString(LOGIN);
                return true;
            }
            let vc = IdentityVerifyViewController();
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LotteryRoutes.addRoute(PAY) { (param: [AnyHashable: Any]?) -> Bool in
            if (LotteryUtil.user() == nil) {
                LotteryRoutes.routeURLString(LOGIN);
                return true;
            }
            
            var vc = PayTableViewController();
            
            if (LotteryUtil.hasSuffix(content: param?["gameEn"] as! String, suffix: "d11") && param?["orderId"] == nil) {
                vc = D11PayTableViewController();
            }
            vc.gameId = param?["gameId"] as? Int;
            vc.gameEn = param?["gameEn"] as? String;
            vc.gameName = param?["gameName"] as? String;
            let totalPeriod = param?["totalPeriod"] as? Int;
            if (totalPeriod != nil && totalPeriod != 1) {
                vc.totalPeriod = totalPeriod;
                vc.followMode = param?["followMode"] as? Int;
            }
            vc.betTimes = param?["betTimes"] as? Int;
            vc.periodId = param?["periodId"] as? String;
            vc.lotteryNumber = param?["lotteryNumber"] as? String;
            vc.orderAmount = (param?["orderAmount"] as? Double)!;
            vc.gameExtra = param?["gameExtra"] as? String;
            vc.balanceAmount = (param?["balanceAmount"] as? Double)!;
            vc.redPacketList = (param?["redPacketList"] as? Array<RedPacket>)!;
            vc.payMethodList = (param?["payMethodList"] as? Array<PayMethod>)!
            vc.orderId = param?["orderId"] as? String;
            
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
// 资讯跳转
        LotteryRoutes.addRoute("/article") { (param: [AnyHashable : Any]?) -> Bool in
            let vc = ArticleListViewController()
            vc.category = param?["category"] as? Int
            ViewUtil.keyViewController().pushViewController(viewController: vc)
            return true
        }
        
    }
    
}
