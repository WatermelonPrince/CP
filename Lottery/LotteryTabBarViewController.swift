//
//  LotteryTabBarViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import StoreKit

class LotteryTabBarViewController: UITabBarController {
    
    var homeViewController = HomeViewController();
    var noticeViewController = NoticeTableViewController();
    var mineViewController = MineViewController();
        
    override func viewDidLoad() {
        super.viewDidLoad();
        
        UIApplication.shared.setStatusBarHidden(false, with: .slide);
        
        let homeNavigationController = LotteryBaseNavigationController(rootViewController: self.homeViewController);
        let noticeNavigationController = LotteryBaseNavigationController(rootViewController: self.noticeViewController);
        let mineNavigationController = LotteryBaseNavigationController(rootViewController: self.mineViewController);
        
        homeNavigationController.tabBarItem.title = "购彩";
        noticeNavigationController.tabBarItem.title = "开奖";
        mineNavigationController.tabBarItem.title = "我";
        
        homeNavigationController.tabBarItem.image = UIImage(named: "icon_home")?.withRenderingMode(.alwaysOriginal);
        homeNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_home_selected")?.withRenderingMode(.alwaysOriginal);
        noticeNavigationController.tabBarItem.image = UIImage(named: "icon_notice")?.withRenderingMode(.alwaysOriginal);
        noticeNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_notice_selected")?.withRenderingMode(.alwaysOriginal);
        mineNavigationController.tabBarItem.image = UIImage(named: "icon_mine")?.withRenderingMode(.alwaysOriginal);
        mineNavigationController.tabBarItem.selectedImage = UIImage(named: "icon_mine_selected")?.withRenderingMode(.alwaysOriginal);
        
        if  (LotteryUtil.homeEntranceList() != nil && LotteryUtil.homeEntranceList()!.count > 6) {
            let controllers = [homeNavigationController, noticeNavigationController, mineNavigationController];
            self.viewControllers = controllers;
        }else{
            let controllers = [homeNavigationController,mineNavigationController];
            self.viewControllers = controllers;
        }
        
        
        
        //TabBar
        self.tabBar.tintColor = COLOR_RED;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}
