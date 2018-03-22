//
//  LotteryBaseTableViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTableViewController: LotteryBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView = LotteryBaseTableView(frame: self.view.frame);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(self.tableView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }

}
