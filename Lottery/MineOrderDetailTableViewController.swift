//
//  MineOrderDetailTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/1.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineOrderDetailTableViewController: LotteryRefreshTableViewController, ServiceDelegate{
    var headerView: MineOrderDetailTableHeaderView!;
    var isDetailShow = false;
    var lotteryNumber = "";
    var orderDetail = OrderDetail();
    var orderService: OrderDetailService!;
    var bottomButtonView: MineOrderDetailBottomButtonView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if (self.orderDetail.orderType == 2) {
            self.title = "追号投注";
        } else {
            self.title = "普通投注";
        }
        
        //TableView
        self.tableView.register(MineOrderDetailTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //HeaderView
        self.headerView = MineOrderDetailTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 130));
        self.tableView.tableHeaderView = self.headerView;
        
        //FooterView
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70));
        
        //BottomView
        self.bottomButtonView = MineOrderDetailBottomButtonView(frame: CGRect(x: 0, y: self.view.frame.height - 70, width: self.view.frame.width, height: 70));
        self.view.addSubview(self.bottomButtonView);
        
        //Service
        self.orderService = OrderDetailService(delegate: self);
        self.beginRefreshing();
        self.headerView.setData(orderDetail: self.orderDetail);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.orderService.getOrderDetail(orderId: self.orderDetail.orderId!);
    }
    
    override func onCompleteSuccess(service: BaseService) {
        self.orderDetail = self.orderService.orderDetail;
        self.headerView.setData(orderDetail: self.orderDetail);
        self.bottomButtonView.setData(orderDetail: self.orderDetail);
        self.loadSuccess();
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70));
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.orderService.orderDetail == nil) {
            return 0;
        }
        return 5;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            if (self.orderDetail.prizeStatus == 0 || self.orderDetail.prizeStatus == nil) {
                return 3;
            } else {
                return 2;
            }
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            if (self.isDetailShow == true && self.orderDetail.lotteryNumVoList != nil) {
                return (self.orderDetail.lotteryNumVoList?.count)!;
            } else {
                return 0;
            }
        } else if (section == 3) {
            if (self.orderDetail.orderType == 2) {
                return 3
            } else {
               return 2;
            }
        } else if (section == 4) {
            return 3;
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 35;
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            if (self.orderDetail.orderStatusCn != nil) {
               height = CommonUtil.getLabelHeight(text: self.orderDetail.orderStatusCn!, width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 15)) + 15;
            }
            
        }
        
        if (indexPath.section == 2) {
            let lotteryNumber = self.orderDetail.lotteryNumVoList?[indexPath.row].lotteryNumber;
            if (lotteryNumber != nil) {
                height = CommonUtil.getLabelHeight(text: lotteryNumber!, width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 15)) + 15;
            }
        }
        
        if (indexPath.section == 4 && indexPath.row == 2) {
            if (self.orderDetail.prompt != nil) {
               height = CommonUtil.getLabelHeight(text: self.orderDetail.prompt!, width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 14)) + 15;
            }
        }
        
        if (height < 35) {
            height = 35;
        }
        
        return height;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MineOrderDetailTableViewCell;
        cell.leftLabel.frame.size.height = 35;
        cell.rightLabel.frame.size.height = 35;
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);
        cell.accessoryType = .none;
        if (indexPath.section == 0) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
            cell.backgroundColor = COLOR_GROUND;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.rightLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            if (indexPath.row == 0) {
                cell.leftLabel.text = "订单状态";
                
                cell.rightLabel.font = UIFont.boldSystemFont(ofSize: 15);
                if (self.orderDetail.orderStatusCn != nil) {
                    cell.rightLabel.text = self.orderDetail.orderStatusCn;
                    if (self.orderDetail.bonusColor == "red") {
                        cell.rightLabel.textColor = COLOR_RED;
                    }
                    cell.rightLabel.frame.size.height = CommonUtil.getLabelHeight(text: self.orderDetail.orderStatusCn!, width: cell.rightLabel.frame.width, font: cell.rightLabel.font) + 15;
                }
                
            } else if (indexPath.row == 1) {
                if (self.orderDetail.prizeStatus == 0 || self.orderDetail.prizeStatus == nil) {
                    cell.leftLabel.text = "预计开奖";
                    cell.rightLabel.font = UIFont.systemFont(ofSize: 15);
                    cell.rightLabel.text = "--";
                    if (self.orderDetail.winningNumbers?.isEmpty != true) {
                       cell.rightLabel.text = self.orderDetail.winningNumbers;
                    }
                } else {
                        cell.leftLabel.text = "开奖号码";
                        cell.rightLabel.font = UIFont.boldSystemFont(ofSize: 15);
                        cell.rightLabel.textColor = COLOR_RED;
                        cell.rightLabel.attributedText = LotteryUtil.winningNumbersAttributedString(winningNumbers: self.orderDetail.winningNumbers);
                }
            } else if (indexPath.row == 2) {
                cell.leftLabel.text = "预计派奖";
                cell.rightLabel.font = UIFont.systemFont(ofSize: 15);
                cell.rightLabel.text = "--";
                if (self.orderDetail.awardTimeValue?.isEmpty != true) {
                    cell.rightLabel.text = self.orderDetail.awardTimeValue;
                }
            }
        } else if (indexPath.section == 1) {
            cell.backgroundColor = COLOR_WHITE;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            cell.leftLabel.text = "选号详情";
            
            cell.rightLabel.textColor = COLOR_FONT_TEXT;
            cell.rightLabel.font = UIFont.systemFont(ofSize: 13);
            if (self.orderDetail.lotteryNumVoList?.count != nil) {
                cell.rightLabel.text = "\((self.orderDetail.lotteryNumVoList?.count)!)条";
            }
            
            if (self.isDetailShow == true) {
                cell.accessoryView = UIImageView(image: UIImage(named: "icon_arrow_up"));
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "icon_arrow_down"));
            }
            
        } else if (indexPath.section == 2) {
            cell.backgroundColor = COLOR_WHITE;
            cell.leftLabel.textColor = COLOR_FONT_SECONDARY;
            cell.leftLabel.font = UIFont.systemFont(ofSize: 11);
            cell.leftLabel.numberOfLines = 2;
            
            let lotteryNumberVo = self.orderDetail.lotteryNumVoList?[indexPath.row];
            cell.leftLabel.text = (lotteryNumberVo?.extraCn)! + "\n" + String(self.orderDetail.betTimes!) + "倍";
            
            cell.rightLabel.textColor = COLOR_FONT_SECONDARY;
            cell.rightLabel.font = UIFont.systemFont(ofSize: 15);
            cell.rightLabel.text = lotteryNumberVo?.lotteryNumber;
            cell.rightLabel.frame.size.height = CommonUtil.getLabelHeight(text: (lotteryNumberVo?.lotteryNumber)!, width: cell.rightLabel.frame.width, font: cell.rightLabel.font) + 15;
            
        } else if (indexPath.section == 3) {
            cell.backgroundColor = COLOR_GROUND;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            cell.rightLabel.text = "";
            cell.accessoryType = .disclosureIndicator;
            if (indexPath.row == 0) {
                cell.leftLabel.text = "出票详情";
            } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
                cell.leftLabel.text = "中奖怎么算？";
            } else {
                cell.leftLabel.text = "追号详情";
                cell.rightLabel.font = UIFont.systemFont(ofSize: 14);
                cell.rightLabel.text = self.orderDetail.followDetail?.followInfo;
            }
        } else if (indexPath.section == 4) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
            cell.backgroundColor = COLOR_GROUND;
            cell.leftLabel.textColor = COLOR_BROWN;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            cell.rightLabel.textColor = COLOR_BROWN;
            cell.rightLabel.font = UIFont.systemFont(ofSize: 14);
            cell.rightLabel.numberOfLines = 0;
            if (indexPath.row == 0) {
                cell.leftLabel.text = "下单时间";
                cell.rightLabel.text = self.orderDetail.orderTimeStr;
            } else if (indexPath.row == 1) {
                cell.leftLabel.text = "订单编号";
                cell.rightLabel.text = self.orderDetail.orderId;
            } else if (indexPath.row == 2) {
                cell.leftLabel.text = "温馨提示";
                cell.rightLabel.text = self.orderDetail.prompt;
                if (self.orderDetail.prompt != nil) {
                    cell.rightLabel.frame.size.height = CommonUtil.getLabelHeight(text: self.orderDetail.prompt!, width: cell.rightLabel.frame.width, font: cell.rightLabel.font) + 15;
                }
                
            }
            
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            self.isDetailShow = !self.isDetailShow;
            tableView.reloadData();
        } else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                let vc = MineTicketDetailViewController();
                vc.orderId = self.orderDetail.orderId;
                self.pushViewController(viewController: vc);
            } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1) {
                LotteryRoutes.routeURLString(HTTPConstants.HELP_GAME+"/" + self.orderDetail.gameEn!)
            } else {
                let vc = MineFollowTableViewController();
                vc.followDetail = self.orderDetail.followDetail!;
                vc.followDetail.gameImageUrl = self.orderDetail.gameImageUrl;
                self.pushViewController(viewController: vc);
            }
        }
    }
    
}
