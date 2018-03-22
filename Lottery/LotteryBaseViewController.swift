//
//  LotteryBaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        //Background
        self.view.backgroundColor = COLOR_GROUND;
        
        let backItem = UIBarButtonItem();
        backItem.title = " ";
        self.navigationItem.backBarButtonItem = backItem;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushViewController(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
}
