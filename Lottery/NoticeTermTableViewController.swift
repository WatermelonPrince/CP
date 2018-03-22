//
//  NoticeTermTableViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeTermTableViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var noticeService: NoticeService!;
    var gameEn: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableView
        self.tableView.register(NoticeTermTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //Service
        self.noticeService = NoticeService(delegate: self);
        
        self.beginRefreshing();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.noticeService.getNotice(gameEn: self.gameEn);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.noticeService.awardInfoList != nil) {
            return self.noticeService.awardInfoList.count;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeTermTableViewCell;
        let isFirst = (indexPath.row == 0) ? true : false;
        cell.setData(isFirst: isFirst, awardInfo: self.noticeService.awardInfoList[indexPath.row]);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }

}
