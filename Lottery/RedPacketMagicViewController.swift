//
//  RedPacketMagicViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
class RedPacketTableViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var status: Int = 0;
    var redPacketService: RedPacketService!;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        //TableView
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64+44, right: 0);
        self.tableView.register(RedPacketTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.emptyButton.emptyImageView = UIImageView(image: UIImage(named: "icon_empty_redpacket"));
        self.emptyButton.descriptionLabel.text = "暂无红包记录";
        
        //Service
        self.redPacketService = RedPacketService(delegate: self);
        
        self.beginRefreshing();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.redPacketService.getRedPacketList(status: self.status);
    }
    
    override func footerRefresh() {
        super.footerRefresh();
        self.redPacketService.getRedPacketList(status: self.status, page: self.redPacketService.page + 1)
    }
    
    override func onCompleteSuccess(service: BaseService) {
        if (self.redPacketService.hasNextPage != nil) {
           self.hasNoMoreData = !self.redPacketService.hasNextPage!;
        }
        self.loadSuccess();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.redPacketService.redPacketList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RedPacketTableViewCell;
        cell.setData(redPacket: self.redPacketService.redPacketList[indexPath.row]);
        return cell;
    }
}

class RedPacketMagicViewController: LotteryBaseMagicViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "红包";

        self.menuTitles = ["可用","待派发","用完/过期"];
        
        for i in 0..<3 {
            let vc = RedPacketTableViewController();
            if (i == 0) {
                vc.status = RedPacket.AVAILABLE;
            } else if (i == 1) {
                vc.status = RedPacket.INIT;
            } else if (i == 2) {
                vc.status = RedPacket.RUNOUT;
            }
            self.viewControllerList.append(vc);
        }
        
        self.magicView.reloadData();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
