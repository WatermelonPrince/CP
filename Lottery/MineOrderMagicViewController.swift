//
//  MineOrderMagicViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineOrderMagicViewController: LotteryBaseMagicViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.menuTitles = ["全部订单","中奖订单","待开奖订单"];
        self.magicView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
