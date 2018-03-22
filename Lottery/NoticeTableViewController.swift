//
//  NoticeTableViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeTableViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var noticeService: NoticeService!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "开奖信息";
        
        //TableView
        self.tableView.register(NoticeTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //Service
        self.noticeService = NoticeService(delegate: self);
        
        self.beginRefreshing();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.noticeService.getNotice();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        if (self.noticeService.awardInfoList.count != 0) {
            LotteryUtil.saveAwardInfoList(awardInfoList: self.noticeService.awardInfoList);
        }
        self.loadSuccess();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let awardInfoList = LotteryUtil.awardInfoList();
        if (awardInfoList != nil) {
            return awardInfoList!.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeTableViewCell;
        cell.setData(awardInfo: LotteryUtil.awardInfoList()![indexPath.row]);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let vc = NoticeTermTableViewController();
        vc.title = LotteryUtil.awardInfoList()![indexPath.row].gameName;
        vc.gameEn = LotteryUtil.awardInfoList()![indexPath.row].gameEn;
        self.pushViewController(viewController: vc);
    }

}
