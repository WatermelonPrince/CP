//
//  LotteryRefreshTableViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryRefreshTableViewController: LotteryBaseTableViewController {
    var hasNoMoreData = true;
    var emptyButton: LotteryBaseEmptyButton!;
    var imageArr = Array<UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad();
        for i in 1...3 {
            let image = UIImage.init(named: String.init(format: "topload_%d", i))
            imageArr.append(image!)
        }
        //mjHeader
        let mjHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh));
        mjHeader?.lastUpdatedTimeLabel.isHidden = true;
        mjHeader?.stateLabel.font = UIFont.systemFont(ofSize: 12);
        mjHeader?.stateLabel.textColor = COLOR_FONT_SECONDARY;
        mjHeader?.setTitle("松开即可刷新...", for: .pulling)
        mjHeader?.setTitle("下拉即可刷新...", for: .idle)
        mjHeader?.setTitle("正在刷新列表...", for: .refreshing)
        
        mjHeader?.setImages(self.imageArr, for:.idle)
        mjHeader?.setImages([self.imageArr[2]], for:.pulling)
        mjHeader?.setImages(self.imageArr, for: .refreshing)



        self.tableView.mj_header = mjHeader;
        
        //mjFooter
        let mjFooter = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh));
        mjFooter?.stateLabel.font = UIFont.systemFont(ofSize: 12);
        mjFooter?.stateLabel.textColor = COLOR_FONT_SECONDARY;
        self.tableView.mj_footer = mjFooter;
//        self.tableView.mj_footer.isHidden = true;
        
        self.emptyButton = LotteryBaseEmptyButton(frame: CGRect(x: self.view.frame.width/4, y: self.view.frame.width/4 + 64, width: self.view.frame.width/2, height: self.view.frame.width/2));
        self.emptyButton.addTarget(self, action: #selector(emptyReloadAction), for: .touchUpInside);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginRefreshing() {
        self.tableView.mj_header.beginRefreshing();
    }
    
    func headerRefresh() {
    }
    
    func footerRefresh() {
    
    }
    
    func onCompleteSuccess(service: BaseService) {
        self.loadSuccess();
    }
    
    func onCompleteFail(service: BaseService) {
        self.loadFail();
    }
    
    func loadSuccess() {
        self.tableView.reloadData();
        self.loadComplete(isSuccess: true);
    }
    
    func loadFail() {
        self.loadComplete(isSuccess: false);
    }
    
    func loadComplete(isSuccess: Bool) {
        if (self.tableView.mj_header.isRefreshing()) {
            self.tableView.mj_header.endRefreshing();
        }
        
        if (self.tableView.mj_footer.isRefreshing()) {
            if (self.hasNoMoreData == false) {
                self.tableView.mj_footer.endRefreshing();
            } else {
                self.tableView.mj_footer.endRefreshingWithNoMoreData();
            }
        }
        
        self.tableView.mj_footer.isHidden = self.hasNoMoreData;
        
        self.setEmptyButton(isSuccess: isSuccess);
    }
    
    func setEmptyButton(isSuccess: Bool) {
        
        if (isSuccess == true) {
            self.emptyButton.isUserInteractionEnabled = false;
            self.emptyButton.descriptionLabel.text = self.emptyButton.descriptionText;
        } else {
            self.emptyButton.isUserInteractionEnabled = true;
            self.emptyButton.descriptionLabel.text = "点击重新加载";
        }
        
        var numberOfCells = 0;
        
        if (self.tableView.numberOfSections == 1) {
            numberOfCells = self.tableView.numberOfRows(inSection: 0);
        } else {
            numberOfCells = self.tableView.numberOfSections;
        }
        
        if (numberOfCells == 0) {
            var tableHeaderViewHeight = self.tableView.tableHeaderView?.frame.height;
            if (tableHeaderViewHeight == nil) {
                tableHeaderViewHeight = 0;
            }
            self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height-tableHeaderViewHeight!-64));
            self.tableView.tableFooterView?.addSubview(self.emptyButton);
        } else {
            self.tableView.tableFooterView = UIView();
        }
    }
    
    func emptyReloadAction() {
        self.emptyButton.descriptionLabel.text = "加载中...";
        self.tableView.mj_header.beginRefreshing();
    }
    

}
