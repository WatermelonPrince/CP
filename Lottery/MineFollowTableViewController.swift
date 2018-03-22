//
//  MineFollowTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/26.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineFollowTableViewController: LotteryRefreshTableViewController {

    var headerView: MineOrderDetailTableHeaderView!;
    var isDetailShow = true;
    var followDetail = FollowDetail();
    var bottomButtonView: MineOrderDetailBottomButtonView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "追号详情";
        
        //TableView
        self.tableView.register(MineOrderDetailTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //HeaderView
        self.headerView = MineOrderDetailTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 130));
        self.tableView.tableHeaderView = self.headerView;
        
        //FooterView
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100));
        
        //BottomView
        self.bottomButtonView = MineOrderDetailBottomButtonView(frame: CGRect(x: 0, y: self.view.frame.height - 70, width: self.view.frame.width, height: 70));
        self.view.addSubview(self.bottomButtonView);
        
        self.headerView.setData(followDetail: self.followDetail);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.loadSuccess();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2;
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            if (self.isDetailShow == true) {
                return (self.followDetail.followOrderVos?.count)!;
            } else {
                return 0;
            }
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 2) {
            return 50;
        }
        return 35;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MineOrderDetailTableViewCell;
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0);
        cell.accessoryType = .none;
        cell.leftLabel.frame.size.height = 35;
        cell.rightLabel.frame.size.height = 35;
        cell.rightLabel.frame.origin.x = cell.leftLabel.frame.maxX;
        cell.rightLabel.textAlignment = .left;
        
        if (indexPath.section == 0) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
            cell.backgroundColor = COLOR_GROUND;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.rightLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            if (indexPath.row == 0) {
                cell.leftLabel.text = "订单状态";
                cell.rightLabel.font = UIFont.boldSystemFont(ofSize: 15);
                cell.rightLabel.text = self.followDetail.followStatusCn;
            } else if (indexPath.row == 1) {
                    cell.leftLabel.text = "停追条件";
                    cell.rightLabel.font = UIFont.systemFont(ofSize: 14);
                    cell.rightLabel.text = self.followDetail.followModeCn;
            }
        } else if (indexPath.section == 1) {
            cell.backgroundColor = COLOR_WHITE;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.boldSystemFont(ofSize: 14);
            cell.leftLabel.text = "追号详情";
            
            cell.rightLabel.textColor = COLOR_FONT_TEXT;
            cell.rightLabel.font = UIFont.systemFont(ofSize: 13);
            cell.rightLabel.text = self.followDetail.followInfo;
            
            if (self.isDetailShow == true) {
                cell.accessoryView = UIImageView(image: UIImage(named: "icon_arrow_up"));
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "icon_arrow_down"));
            }
            
        } else if (indexPath.section == 2) {
            let followOrder = self.followDetail.followOrderVos?[indexPath.row];
            
            cell.backgroundColor = COLOR_WHITE;
            cell.leftLabel.frame.size.height = 50;
            cell.leftLabel.textColor = COLOR_FONT_TEXT;
            cell.leftLabel.font = UIFont.systemFont(ofSize: 13);
            cell.leftLabel.numberOfLines = 2;
            cell.leftLabel.text = (followOrder?.periodId)! + "期\n" + String(Int((followOrder?.orderAmount)!)) + "元";
            
            cell.rightLabel.frame.size.height = 50;
            cell.rightLabel.textAlignment = .right;
            cell.rightLabel.frame.origin.x -= 20;
            cell.rightLabel.textColor = COLOR_FONT_TEXT;
            cell.rightLabel.font = UIFont.systemFont(ofSize: 15);
            
            cell.rightLabel.text = followOrder?.orderStatusCn;
            
            if (followOrder?.statusCnColor == "gray") {
                cell.rightLabel.textColor = COLOR_FONT_SECONDARY;
            } else if (followOrder?.statusCnColor == "red") {
                cell.rightLabel.textColor = COLOR_RED;
                cell.rightLabel.font = UIFont.boldSystemFont(ofSize: 16);
            } else if (followOrder?.statusCnColor == "black") {
                cell.rightLabel.textColor = COLOR_FONT_TEXT;
                cell.rightLabel.font = UIFont.boldSystemFont(ofSize: 15);
            }
            
            cell.accessoryType = .disclosureIndicator;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            self.isDetailShow = !self.isDetailShow;
            tableView.reloadData();
        } else if (indexPath.section == 2) {
            let vc = MineOrderDetailTableViewController();
            let followOrder = self.followDetail.followOrderVos?[indexPath.row];
            vc.orderDetail.orderId = followOrder?.orderId;
            vc.orderDetail.orderAmount = followOrder?.orderAmount;
            vc.orderDetail.periodId = followOrder?.periodId;
            vc.orderDetail.bonus = followOrder?.bonus;
            vc.orderDetail.gameName = self.followDetail.gameName;
            vc.orderDetail.orderType = 2;
            self.pushViewController(viewController: vc);
        }
    }

}
