//
//  MineTicketDetailViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/26.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineTicketDetailViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var ticketListService: TicketListService!;
    var orderId: String!;

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "出票详情";
        
        //TableView
        self.tableView.register(MineOrderDetailTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.tableView.mj_footer.isHidden = false;
        
        //HeaderView
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20));
        headerView.backgroundColor = COLOR_GROUND;
        self.tableView.tableHeaderView = headerView;
        
        //FooterView
        self.tableView.tableFooterView = UIView();
        
        self.ticketListService = TicketListService(delegate: self);
        
        self.beginRefreshing();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.ticketListService.getTicketList(orderId: self.orderId);
    }
    
    override func footerRefresh() {
        super.footerRefresh();
        self.ticketListService.getTicketList(page: self.ticketListService.page + 1, orderId: self.orderId);
    }
    
    override func onCompleteSuccess(service: BaseService) {
        self.loadSuccess();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ticketListService.ticketList.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 35;
        
        let ticket = self.ticketListService.ticketList[indexPath.section];
        
        if (indexPath.row == 0) {
            height = CommonUtil.getLabelHeight(text: ticket.ticketStatusCn!, width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 14)) + 15;
        }
        
        if (indexPath.row == 2) {
            height = CommonUtil.getLabelHeight(text: self.getLotteryNumberContent(ticket: ticket), width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 14)) + 15;
        }
        
        if (height < 35) {
            height = 35
        }
        
        return height;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 20));
        view.backgroundColor = COLOR_GROUND;
        return view;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MineOrderDetailTableViewCell;
        cell.accessoryType = .none;
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
        cell.leftLabel.frame.size.width = 75;
        cell.leftLabel.font = UIFont.systemFont(ofSize: 14);
        cell.leftLabel.textColor = COLOR_FONT_TEXT;
        cell.rightLabel.frame.origin.x = cell.leftLabel.frame.maxX;
        cell.rightLabel.font = cell.leftLabel.font;
        cell.rightLabel.textColor = COLOR_BROWN;
        cell.rightLabel.frame.size.height = 35;
        
        let ticket = self.ticketListService.ticketList[indexPath.section];
        
        if (indexPath.row == 0) {
            cell.leftLabel.text = "出票状态：";
            cell.rightLabel.text = ticket.ticketStatusCn;
            cell.rightLabel.frame.size.height = CommonUtil.getLabelHeight(text: ticket.ticketStatusCn!, width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 14)) + 15;
        } else if (indexPath.row == 1) {
            cell.leftLabel.text = "中奖状态：";
            cell.rightLabel.text = ticket.prizeStatusCn;
        } else if (indexPath.row == 2) {
            cell.leftLabel.text = "选号详情："
            
            cell.rightLabel.text = self.getLotteryNumberContent(ticket: ticket);
            cell.rightLabel.frame.size.height = CommonUtil.getLabelHeight(text: self.getLotteryNumberContent(ticket: ticket), width: MineOrderDetailTableViewCell().rightLabel.frame.width, font: UIFont.systemFont(ofSize: 14)) + 15;
        }
        
        return cell;
    }
    
    func getLotteryNumberContent(ticket: Ticket) -> String {
        var lotteryNumbersContent = "";
        for number in ticket.lotteryNumbers! {
            if (lotteryNumbersContent == "" ) {
                lotteryNumbersContent.append("[\(ticket.extraCn!)] " + number + " [\(ticket.times!)倍]");
            } else {
                lotteryNumbersContent.append("\n" + "[\(ticket.extraCn!)] " + number + " [\(ticket.times!)倍]");
            }
        }
        return lotteryNumbersContent;
    }

}
