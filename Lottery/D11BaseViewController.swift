//
//  D11BaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11BaseDescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_FONT_TEXT;
        self.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LotteryDeadlineButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.contentHorizontalAlignment = .center;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class D11BaseViewController: LotteryBoardBaseViewController {
    var deadlineButton: LotteryDeadlineButton!;
    var descriptionLabel: D11BaseDescriptionLabel!
    var prizeContent = "0" {
        didSet {
            self.setDescriptionLabel();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = self.gameName;
        self.navController = D11OrderViewController();
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.navController.gameEn = self.gameEn;
        
        //截止Label
        self.deadlineButton = LotteryDeadlineButton(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 25));
        self.view.addSubview(self.deadlineButton);
        
        //ScrollView
        self.scrollView.frame.origin.y = self.deadlineButton.frame.maxY;
        self.scrollView.layer.borderColor = COLOR_BORDER.cgColor;
        self.scrollView.layer.borderWidth = 0.5;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navAction() {
        //如果有订单页则返回并添加新的cell
        for viewController in (self.navigationController?.viewControllers)! {
            if (viewController.isKind(of: D11OrderViewController().classForCoder)) {
                self.navController = viewController as! D11OrderViewController;
                _ = self.navigationController?.popViewController(animated: true);
                if (self.editBallStringArray.count > 0) {
                    //修改
                    self.navController.ballStringArray[self.navController.editedRow] = self.editBallStringArray[0];
                    
                    if (self.editBallStringArray.count > 1) {
                        for i in 1..<self.editBallStringArray.count {
                            self.navController.ballStringArray.insert(self.editBallStringArray[i], at: self.navController.editedRow + i);
                        }
                    }
                    self.navController.tableView.reloadData();
                } else {
                    //添加
                    self.navController.insertRows(newArray: self.newBallStringArray);
                }
                return;
            }
        }
        
        //没有订单页则创建
        self.navController.insertRows(newArray: self.newBallStringArray);
        (self.navController as! D11OrderViewController).deadlineTimeInterval = (self.parent as! D11MainViewController).deadlineTimeInterval;
        self.pushViewController(viewController: self.navController);
        
    }
    
    func setDescriptionLabel() {
        
    }
    
}
