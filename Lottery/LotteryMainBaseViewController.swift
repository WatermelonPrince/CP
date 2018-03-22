//
//  LotteryMainBaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryMainBaseViewController: LotteryBaseViewController, ServiceDelegate {
    var gameEn = "";
    var gameName = "";
    var rule = "";
    var gameId: Int!;
    var periodId: String!;
    var childVCs = Array<LotteryBoardBaseViewController>();
    var gameNameArray = Array<String>();
    var titleNameArray = Array<String>();
    var currentViewController: LotteryBoardBaseViewController!;
    var dropDownButton: LotteryMainBaseDropDownButton!;
    var dropDownView: LotteryMainBaseDropDownView!;
    var selectedInt = 0;
    var editBallStringArray = Array<String>();
    var awardInfoMap: Dictionary<String, String>!;
    
    var betService: BetService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "助手", style: .plain, target: self, action: #selector(helperAction(_:)));
        
        //ChildVCs
        for childVC in self.childVCs {
            childVC.gameEn = self.gameEn;
            childVC.gameName = self.gameName;
            childVC.gameId = self.gameId;
            childVC.editBallStringArray = self.editBallStringArray;
            self.addChildViewController(childVC);
        }
        
        self.currentViewController = self.childVCs[selectedInt];
        self.currentViewController.isShown = true;
        if (self.editBallStringArray.count > 0) {
           self.currentViewController.isForEdit = true;
        }
        
        self.currentViewController.didMove(toParentViewController: self);
        self.view.addSubview(self.currentViewController.view);
        
        //DropDownButton
        self.dropDownButton = LotteryMainBaseDropDownButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30));
        self.dropDownButton.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside);
        self.navigationItem.titleView = self.dropDownButton;
        
        //DropDownView
        self.dropDownView.maskButton.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside);
        self.dropDownView.isHidden = true;
        self.dropDownView.selectedButtonInt = self.selectedInt;
        self.dropDownView.resetAction();
        self.dropDownButton.setData(name: self.titleNameArray[self.selectedInt], show: !self.dropDownView.isHidden);
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(changeCurrentController), name: NSNotification.Name(rawValue: "DropDownButtonChange"), object: nil);
        
        //Service
        self.betService = BetService(delegate: self);
        self.getPeriodInfo();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DropDownButtonChange"), object: nil);
    }
    
    func getPeriodInfo() {
        self.betService.getPeriods(gameEn: self.gameEn);
    }

    
    func onCompleteSuccess(service: BaseService) {
        let currentSubPeriod = self.betService.currentSubPeriod;
        if (self.periodId != nil && currentSubPeriod != nil && self.periodId != self.betService.currentPeriod.periodId) {
            ViewUtil.showToast(text: "期次已切换，当前是第\(currentSubPeriod!)期");
        }
        self.gameId = self.betService.currentPeriod.gameId;
        if (self.betService.currentPeriod.gameName != nil) {
           self.gameName = self.betService.currentPeriod.gameName!;
        }
        self.awardInfoMap = self.betService.awardInfoMap;
        self.periodId = self.betService.currentPeriod.periodId;
        for childVC in (self.childViewControllers as! [LotteryBoardBaseViewController]).enumerated() {
            childVC.element.gameId = self.gameId;
            childVC.element.periodId = self.periodId;
            childVC.element.gameName = self.gameName;
            
            if (childVC.element.isKind(of: D11BaseViewController.classForCoder()) && self.awardInfoMap != nil) {
                var awardInfoMapKey = "";
                if (childVC.offset < 12) {
                    awardInfoMapKey = "\(childVC.offset+1)";
                } else if (childVC.offset < 19) {
                    awardInfoMapKey = "\(childVC.offset+1-12)";
                } else if (childVC.offset == 19) {
                    awardInfoMapKey = "10";
                } else if (childVC.offset == 20) {
                    awardInfoMapKey = "12";
                }
                
                if (self.awardInfoMap[awardInfoMapKey] != nil) {
                   (childVC.element as! D11BaseViewController).prizeContent = self.awardInfoMap[awardInfoMapKey]!;
                }
                
            }
        }
    }
    
    func dropDownAction() {
        if (self.dropDownView == nil) {
            return;
        }
        self.view.bringSubview(toFront: self.dropDownView);
        if (self.dropDownView.isHidden == true) {
            self.dropDownView.isHidden = false;
        } else {
            self.dropDownView.isHidden = true;
            
        }
        self.dropDownButton.setData(name: self.titleNameArray[self.selectedInt], show: !self.dropDownView.isHidden);
    }
    
    func changeCurrentController() {
        if (self.dropDownView == nil) {
            return;
        }
        self.selectedInt = self.dropDownView.selectedButtonInt;
        if (self.currentViewController != self.childVCs[self.selectedInt]) {
            self.transition(from: self.currentViewController, to: self.childVCs[self.selectedInt], duration: 0, options: UIViewAnimationOptions.transitionCurlUp, animations: nil, completion: nil);
            self.currentViewController = self.childVCs[self.selectedInt];
            
            for vc in self.childVCs {
                vc.isShown = false;
            }
            self.currentViewController.isShown = true;
            
            self.currentViewController.dropDownButtonChangeAction();
        }
        
        self.dropDownAction();
    }
    
    func cancelAction() {
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    func helperAction(_ sender: UIBarButtonItem) {
        if (self.dropDownView != nil && !self.dropDownView.isHidden) {
            self.dropDownAction();
        }
        
        let action1 = PopoverAction(title: "玩法说明") { (action) in
            let urlContent = HTTPConstants.HELP_GAME + "/" + self.gameEn;
            LotteryRoutes.routeURLString(urlContent);
        }
        let popoverView = PopoverView();
        popoverView.show(to: CGPoint(x: self.view.frame.maxX, y: (self.navigationController?.navigationBar.frame.maxY)!), with: [action1!]);
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (LotteryUtil.isEnabledShakeAction() == false || LotteryUtil.isEnabledShakeAction() == nil) {
            return;
        }
        self.currentViewController.motionBegan(motion, with: event);
    }

}
