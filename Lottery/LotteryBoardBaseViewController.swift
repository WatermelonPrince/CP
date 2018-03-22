//
//  LotteryBoardBaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBoardBaseViewController: LotteryBaseViewController {
    var gameEn = "";
    var gameId: Int!;
    var gameName = "";
    var periodId: String!;
    var shakeTimer: Timer?;
    var scrollView: UIScrollView!;
    var isShown = false;
    var bottomBarView: LotteryBallBoardBottomBarView!;
    var newBallStringArray = Array<String>();
    var editBallStringArray = Array<String>();
    var isForEdit = false;
    var navController: LotteryOrderViewController!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(ballNumberChangeAction(_:)), name: NSNotification.Name(rawValue: "BallNumberChange"), object: nil);
        
        //ScrollView
        self.scrollView = UIScrollView(frame: self.view.bounds);
        self.scrollView.frame.origin.y = 64;
        self.scrollView.contentSize = self.view.frame.size;
        self.view.addSubview(self.scrollView);
        
        //底部bar
        self.bottomBarView = LotteryBallBoardBottomBarView(frame: CGRect(x: 0, y: self.view.frame.height-45, width: self.view.frame.width, height: 45));
        self.view.addSubview(self.bottomBarView);
        self.bottomBarView.clearButton.addTarget(self, action: #selector(clearAction), for: .touchUpInside);
        self.bottomBarView.machineSelectionButton.addTarget(self, action: #selector(machineSelectionAction(_:)), for: .touchUpInside);
        self.bottomBarView.confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "BallNumberChange"), object: nil);
        self.shakeTimer?.invalidate();
        self.shakeTimer = nil;
    }
    
    func machineSelectionAction(_ button: UIButton) {
        let popImage = UIImage(named: "icon_moneybag");
        let action1 = PopoverAction(image: popImage, title: " 1注") { (action) in
            self.machineSelectionBasicAction(count: 1);
        }
        let action2 = PopoverAction(image: popImage, title: " 5注") { (action) in
            self.machineSelectionBasicAction(count: 5);
        }
        let action3 = PopoverAction(image: popImage, title: "10注") { (action) in
            self.machineSelectionBasicAction(count: 10);
        }
        let popoverView = PopoverView();
        popoverView.show(to: button, with: [action1!, action2!, action3!]);
    }
    
    func machineSelectionBasicAction(count: Int) {
        self.newBallStringArray.removeAll();
        self.editBallStringArray.removeAll();
    }
    
    func ballNumberChangeAction(_ notification: Notification) {
        
    }
    
    func clearAction() {
        for view in self.scrollView.subviews {
            if (view.isKind(of: LotteryBaseBallBoardView.classForCoder())) {
                let ballBoardView = view as! LotteryBaseBallBoardView;
                ballBoardView.clearAction();
            }
        }
    }
    
    func confirmAction() {
        
    }
    
    func shakeVibrateAction() {
        self.shakeAction();
        CommonUtil.vibrate();
    }
    
    func shakeAction() {
        self.clearAction();
        if (self.shakeTimer != nil) {
            return;
        }
        self.shakeTimer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(autoSelectAction), userInfo: nil, repeats: true);
        self.view.isUserInteractionEnabled = false;
    }
    
    func autoSelectAction() {
        
    }
    
    func dropDownButtonChangeAction() {
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
    }
}
