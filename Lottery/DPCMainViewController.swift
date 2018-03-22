//
//  DPCMainViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCMainViewController: LotteryMainBaseViewController {

    override func viewDidLoad() {
        //DropDownView
        self.dropDownView = DPCMainDropDownView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), gameNameArray: self.gameNameArray);
        self.view.addSubview(self.dropDownView);
        
        super.viewDidLoad();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
