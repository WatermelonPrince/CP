//
//  HomeQuickOrderView.swift
//  Lottery
//
//  Created by DTY on 2017/5/5.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
class HomeQuickOrderBallView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.backgroundColor = COLOR_WHITE;
        self.layer.cornerRadius = self.frame.width/2;
        self.layer.borderWidth = 1;
        self.textAlignment = .center;
        self.font = UIFont.systemFont(ofSize: frame.width*0.4);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBall(ballColor: BallColor, ballIntNumber: Int) {
        if (ballColor == .red) {
            self.layer.borderColor = COLOR_RED.cgColor;
            self.textColor = COLOR_RED;
        } else {
            self.layer.borderColor = COLOR_BLUE.cgColor;
            self.textColor = COLOR_BLUE;
        }
        self.text = CommonUtil.toBallNumberString(i: ballIntNumber);
    }
    
    func rotate360Degree(duration: Double) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = -Double.pi*2// 旋转角度
        rotationAnimation.duration = CFTimeInterval(duration) // 旋转周期
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 1 // 旋转次数
        self.layer.add(rotationAnimation, forKey: "rotationAnimation");
    }
}


class HomeQuickOrderBallListView: UIView {
    var ballViewList = Array<HomeQuickOrderBallView>();
    var ballWidth: CGFloat!;
    var ballMargin: CGFloat!;
    var moveInt = 0;
    
    var randomBallString: String!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.ballWidth = self.frame.width/8*0.8;
        self.ballMargin = self.frame.width/8*0.2;
        for _ in 0..<7 {
            let ballView = HomeQuickOrderBallView(frame: CGRect(x:(ballWidth+ballMargin)*7, y:0, width:ballWidth,height:ballWidth));
            self.addSubview(ballView);
            ballView.alpha = 0;
            self.ballViewList.append(ballView);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBallViewNumber(redBallIntList: Array<Int>, blueBallIntList: Array<Int>) {
        for ballIntNumber in redBallIntList.enumerated() {
            self.ballViewList[ballIntNumber.offset].setBall(ballColor: .red, ballIntNumber: ballIntNumber.element);
        }
        for ballIntNumber in blueBallIntList.enumerated() {
            self.ballViewList[redBallIntList.count+ballIntNumber.offset].setBall(ballColor: .blue, ballIntNumber: ballIntNumber.element);
        }
    }
    
    func startMoveBallView() {
        for ballView in self.ballViewList {
            ballView.frame.origin.x = (self.ballWidth+self.ballMargin)*7;
            ballView.alpha = 0;
        }
        self.moveInt = 0;
        
        self.randomBallString = LotteryUtil.randomStringDPCNormal(totalRed: 33, minRed: 6, totalBlue: 16, minBlue: 1);
        let ballIntArrayList = LotteryUtil.toBallIntArrayDPCNormal(string: self.randomBallString);
        let redBallIntArray = ballIntArrayList[0];
        let blueBallIntArray = ballIntArrayList[1];
        self.setBallViewNumber(redBallIntList: redBallIntArray, blueBallIntList: blueBallIntArray);
        
        self.moveBallViewAction();
    }
    
    func moveBallViewAction() {
        self.ballViewList[self.moveInt].isHidden = false;
        let duration = Double(8-self.moveInt)*0.063;
        UIView.animate(withDuration: duration, animations: {
            let moveBallView = self.ballViewList[self.moveInt];
            moveBallView.alpha = 1;
            moveBallView.frame.origin.x = (self.ballWidth + self.ballMargin)*CGFloat(self.moveInt);
            moveBallView.rotate360Degree(duration: duration);
        }) { (bool) in
            if (self.moveInt == self.ballViewList.count-1) {
                return;
            }
            self.moveInt = self.moveInt+1;
            self.moveBallViewAction();
        }
        
    }
}

class HomeQuickOrderView: UIView, ServiceDelegate {
    var lotteryLabel: UILabel!;
    var changeButton: UIButton!;
    var ballListView: HomeQuickOrderBallListView!;
    var orderButton: UIButton!;
    var period: Period!;
    
    var homeService: HomeService!;
    var prepayService: PrepayService!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        let leftWidth = (self.frame.width-15*2)*0.8+10;
        let rightWidth = (self.frame.width-15*2)*0.2;
        //LotteryLabel
        self.lotteryLabel = UILabel(frame: CGRect(x: 15, y: 15, width: leftWidth, height: 20));
        self.addSubview(self.lotteryLabel);
        
        //ChangeButton
        self.changeButton = UIButton(frame: CGRect(x: self.frame.width-rightWidth-15, y: self.lotteryLabel.frame.minY, width: rightWidth, height: self.lotteryLabel.frame.height));
        self.changeButton.contentHorizontalAlignment = .right;
        self.changeButton.setTitle("🔄 换一注", for: .normal);
        self.changeButton.setTitleColor(COLOR_FONT_SECONDARY, for: .normal);
        self.changeButton.setTitleColor(COLOR_BROWN, for: .highlighted);
        self.changeButton.titleLabel?.font = UIFont.systemFont(ofSize: K_FONT_SIZE*0.85);
        self.addSubview(self.changeButton);
        self.changeButton.addTarget(self, action: #selector(startMoveBallView), for: .touchUpInside);
        
        //BallListView
        self.ballListView = HomeQuickOrderBallListView(frame: CGRect(x: self.lotteryLabel.frame.minX, y: self.lotteryLabel.frame.maxY+15, width: self.lotteryLabel.frame.width, height: self.frame.height-self.lotteryLabel.frame.maxY-15*2));
        self.addSubview(self.ballListView);
        
        //OrderButton
        self.orderButton = LotteryBaseButton(frame: CGRect(x: self.changeButton.frame.minX, y: self.ballListView.frame.minY, width: rightWidth, height: self.ballListView.frame.height*0.85));
        self.orderButton.setTitle("立即投注", for: .normal);
        self.orderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: K_FONT_SIZE*0.85);
        self.addSubview(self.orderButton);
        self.orderButton.addTarget(self, action: #selector(orderAction), for: .touchUpInside);
        
        let tabBarController = ViewUtil.keyViewController().navigationController?.tabBarController as? LotteryTabBarViewController;
        let homeViewController = tabBarController?.homeViewController;
        if (homeViewController != nil && homeViewController?.homeService != nil && homeViewController?.homeService.hotGamePeriod != nil) {
            self.setData(hotTitle: (homeViewController?.homeService.hotTitle)!, hotTips: (homeViewController?.homeService.hotTips)!, hotPeriod: homeViewController?.homeService.hotGamePeriod);
        } else {
            self.setData(hotTitle: "双色球", hotTips: "", hotPeriod: nil);
        }
        
        self.startMoveBallView();
        
        self.homeService = HomeService(delegate: self);
        self.prepayService = PrepayService(delegate: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(hotTitle: String, hotTips: String, hotPeriod: Period?) {
        //LotteryLabel
        let lotteryAttText = NSMutableAttributedString(string: "双色球", attributes: [NSForegroundColorAttributeName: COLOR_FONT_TEXT, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)]);
        lotteryAttText.append(NSMutableAttributedString(string: "  \(hotTips)", attributes: [NSForegroundColorAttributeName: COLOR_FONT_SECONDARY, NSFontAttributeName: UIFont.systemFont(ofSize: 12)]));
        self.lotteryLabel.attributedText = lotteryAttText;
        
        self.period = hotPeriod;
    }
    
    func startMoveBallView() {
        self.ballListView.startMoveBallView();
    }
    
    func orderAction() {
        if (LotteryUtil.isLogin() != true) {
            LotteryUtil.shouldLogin();
            return;
        }
        
        if (self.period == nil || self.period.gameId == nil) {
            self.homeService.getHome();
            ViewUtil.showProgressToast();
            return;
        }
        
        self.prepayService.getPrepayInfo(gameId: self.period.gameId, orderAmount:2, isFollow: false);
    }
    
    func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        
        if (service == self.homeService) {
            //HotPeriod
            self.setData(hotTitle: self.homeService.hotTitle, hotTips: self.homeService.hotTips, hotPeriod: self.homeService.hotGamePeriod);
        } else if (service == self.prepayService) {
            var parameters = Dictionary<String, Any>();
            parameters["gameId"] = self.period.gameId;
            parameters["gameEn"] = "ssq";
            parameters["gameName"] = self.period.gameName;
            parameters["betTimes"] = 1;
            parameters["periodId"] = self.period.periodId;
            parameters["lotteryNumber"] = self.ballListView.randomBallString;
            parameters["orderAmount"] = 2.00;
            parameters["balanceAmount"]  = self.prepayService.accountBalance;
            parameters["redPacketList"] = self.prepayService.redPacketList;
            parameters["payMethodList"] = self.prepayService.payMethodList;

            LotteryRoutes.routeURLString(HostRouter.JUMP_HOST + HostRouter.PAY, withParameters: parameters);
        }

    }
        
}


