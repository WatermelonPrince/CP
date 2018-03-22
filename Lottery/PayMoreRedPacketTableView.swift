//
//  PayMoreRedPacketTableView.swift
//  Lottery
//
//  Created by DTY on 2017/4/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayMoreRedPacketTableView: LotteryBaseTableView, UITableViewDelegate, UITableViewDataSource {
    var selectedInt: Int = -1;
    var redPacketList = Array<RedPacket>();

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.delegate = self;
        self.dataSource = self;
        
        self.register(RedPacketTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.redPacketList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RedPacketTableViewCell;
        if (indexPath.row == self.selectedInt) {
            cell.accessoryView = UIImageView(image: UIImage(named:"icon_selected"));
        } else {
            cell.accessoryView = UIImageView(image: UIImage(named:"icon_unselected"));
        }
        
        cell.setDataForGame(redPacket: self.redPacketList[indexPath.row]);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        self.selectedInt = indexPath.row;
        self.reloadData();
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "MoreRedPacketDidSelectAction"), object: self.selectedInt, userInfo: nil));
    }

}
