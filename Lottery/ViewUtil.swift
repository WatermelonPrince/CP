//
//  ViewUtil.swift
//  Lottery
//
//  Created by DTY on 17/2/3.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ViewUtil: NSObject {
    
    static func keyViewController() -> LotteryBaseViewController {
        let rootViewController = KEY_WINDOW.rootViewController!;
        if (rootViewController.isKind(of: UITabBarController.classForCoder())) {
            let navigationController = (rootViewController as! UITabBarController).selectedViewController! as! UINavigationController;
            let visibleViewController = navigationController.visibleViewController;
            var viewController = LotteryBaseViewController();
            if (visibleViewController?.isKind(of: VTMagicController.classForCoder()) == true) {
                viewController = (visibleViewController as! VTMagicController).currentViewController as! LotteryBaseViewController;
            } else {
                viewController = navigationController.visibleViewController! as! LotteryBaseViewController
            }
            return viewController;
        } else if (rootViewController.isKind(of: UINavigationController.classForCoder())) {
            let viewController = (rootViewController as! UINavigationController).visibleViewController! as! LotteryBaseViewController;
            return viewController;
        } else if (rootViewController.isKind(of: UIViewController.classForCoder())) {
            return rootViewController as! LotteryBaseViewController;
        }
        
        return LotteryBaseViewController();
    }
    
    static func showToast(text: String) {
        ViewUtil.dismissToast();
        let hud = MBProgressHUD.showAdded(to: KEY_WINDOW, animated: true);
        hud.isUserInteractionEnabled = false;
        hud.bezelView.color = CommonUtil.colorWithAlpha(color: COLOR_BLACK, alpha: 0.7);
        hud.mode = .text;
        hud.label.textColor = COLOR_WHITE;
        hud.label.text = text;
        hud.hide(animated: true, afterDelay: 1.8);
    }
    
    static func showProgressToast() {
        ViewUtil.showProgressToast(text: "");
    }
    
    static func showProgressToast(text: String) {
        ViewUtil.dismissToast();
        let hud = MBProgressHUD.showAdded(to: ViewUtil.keyViewController().view, animated: true);
        hud.isUserInteractionEnabled = false;
        hud.bezelView.color = CommonUtil.colorWithAlpha(color: COLOR_BLACK, alpha: 0.7);
        hud.mode = .indeterminate;
        hud.contentColor = COLOR_WHITE;
        if (text != "") {
            hud.label.textColor = COLOR_WHITE;
            hud.label.text = text;
        }
        ViewUtil.keyViewController().view.isUserInteractionEnabled = false;
    }
    //隐藏掉已经存在HUD并开启最上层控制器的事件响应
    static func dismissToast() {
        MBProgressHUD.hide(for: ViewUtil.keyViewController().view, animated: true);
        ViewUtil.keyViewController().view.isUserInteractionEnabled = true;
    }
    
    static func shakeAnimationForView(view: UIView) {
        let viewLayer = view.layer;
        let position = viewLayer.position;
        let x = CGPoint(x: position.x, y: position.y+5);
        let y = CGPoint(x: position.x, y: position.y-5);
        let animation = CABasicAnimation(keyPath: "position");
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault);
        animation.fromValue = NSValue(cgPoint: x);
        animation.toValue = NSValue(cgPoint: y);
        animation.autoreverses = true;
        animation.duration = 0.06;
        animation.repeatCount = 2;
        viewLayer.add(animation, forKey: nil);
    }
}
