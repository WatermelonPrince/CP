//
//  MineOrderDetailBottomButtonView.swift
//  Lottery
//
//  Created by DTY on 2017/5/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineOrderDetailBottomButtonView: UIView, ServiceDelegate {
    var bottomButton: LotteryBaseButton!;
    var orderDetail: OrderDetail!
    var balanceAmount = 0.00;
    var redPacketList = Array<RedPacket>();
    var prepayService: PrepayService!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.backgroundColor = COLOR_WHITE;
        self.bottomButton = LotteryBaseButton(frame: CGRect(x: 12, y: 12, width: self.frame.width-12*2, height: self.frame.height-12*2));
        self.addSubview(self.bottomButton);
        self.bottomButton.addTarget(self, action: #selector(bottomButtonAction), for: .touchUpInside);
        self.isHidden = true;
        self.prepayService = PrepayService(delegate: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCompleteSuccess(service: BaseService) {
        var parameters = Dictionary<String, Any>();
        parameters["gameId"] = self.orderDetail.gameId;
        parameters["gameEn"] = self.orderDetail.gameEn;
        parameters["gameName"] = self.orderDetail.gameName;
        parameters["totalPeriod"] = self.orderDetail.followDetail?.followOrderVos?.count;
        parameters["periodId"] = self.orderDetail.periodId;
        parameters["orderAmount"] = self.orderDetail.orderAmount;
        if (self.orderDetail.followDetail != nil) {
            parameters["orderAmount"] = self.orderDetail.followDetail?.amount;
        }
        parameters["balanceAmount"] = self.prepayService.accountBalance;
        parameters["redPacketList"] = self.prepayService.redPacketList;
        parameters["payMethodList"] = self.prepayService.payMethodList;
        parameters["orderId"] = self.orderDetail.orderId;
        if (self.orderDetail.followDetail != nil) {
            parameters["orderId"] = self.orderDetail.followDetail?.followId;
        }
        
        if (self.orderDetail.followDetail != nil) {
            let alertController = UIAlertController(title: "确认支付", message: "当前订单为追号订单，订单金额：\(CommonUtil.formatDoubleString(double: (self.orderDetail.followDetail?.amount)!))元", preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            alertController.addAction(UIAlertAction(title: "去支付", style: .default, handler: { (action) in
                LotteryRoutes.routeURLString(HostRouter.JUMP_HOST + "pay", withParameters: parameters);
            }));
            alertController.show();
        } else {
            LotteryRoutes.routeURLString(HostRouter.JUMP_HOST + "pay", withParameters: parameters);
        }
    }
    
    func setData(orderDetail: OrderDetail) {
        self.orderDetail = orderDetail;
        if (self.orderDetail.orderStatus == 0) {
            self.bottomButton.setTitle("立即支付", for: .normal);
        } else {
            self.bottomButton.setTitle("\(self.orderDetail.gameName!)投注", for: .normal);
        }
        self.isHidden = false;
    }
    
    func bottomButtonAction() {
        if (self.orderDetail.orderStatus == 0) {
            self.prepayService.getPrePayInfo(orderId: self.orderDetail.orderId!);
        } else {
            var parameters = Dictionary<String, Any>();
            parameters["gameId"] = self.orderDetail.gameId;
            parameters["gameEn"] = self.orderDetail.gameEn;
            parameters["gameName"] = self.orderDetail.gameName;
            LotteryRoutes.routeURLString(HostRouter.JUMP_HOST + "bet", withParameters: parameters);
        }
    }

}
