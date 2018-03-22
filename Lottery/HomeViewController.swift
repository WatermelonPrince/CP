//
//  HomeViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeViewController: LotteryRefreshTableViewController, SDCycleScrollViewDelegate, ServiceDelegate {
    
    var cycleScrollView: SDCycleScrollView!;
    var quickOrderView: HomeQuickOrderView!;
    var entranceList = Array<Entrance>();
    var redPacketButton: UIButton!;
    
    var homeService: HomeService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "红红彩";
        
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/5*2+10));
        tableHeaderView.backgroundColor = COLOR_GROUND;
        
        //Banner
        self.cycleScrollView = LotteryCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: SCREEN_WIDTH/5*2), delegate: self, placeholderImage: nil);
        tableHeaderView.addSubview(self.cycleScrollView);
        self.cycleScrollView.delegate = self;
        self.setBannerImageUrl();
        //QuickOrderView
//        self.quickOrderView = HomeQuickOrderView(frame: CGRect(x: 0, y: self.cycleScrollView.frame.maxY, width: self.tableView.frame.width, height: 100));
//        tableHeaderView.addSubview(self.quickOrderView);
        self.tableView.tableHeaderView = tableHeaderView;
        
        //EntranceList
        if (LotteryUtil.homeEntranceList() != nil) {
            self.entranceList = LotteryUtil.homeEntranceList()!;
        }
        
        //TableView
        self.tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //redPacket
        let redPacketWidth = SCREEN_WIDTH*0.13;
        self.redPacketButton = UIButton(frame: CGRect(x: SCREEN_WIDTH-redPacketWidth-10, y: SCREEN_HEIGHT-redPacketWidth-100, width: redPacketWidth, height: redPacketWidth));
        self.redPacketButton.sd_setImage(with: CommonUtil.getURL(LotteryUtil.cornerBanner()?.imgUrl), for: .normal);
        self.redPacketButton.addTarget(self, action: #selector(cornerBannerAction), for: .touchUpInside);
        self.view.addSubview(self.redPacketButton);
        
        self.homeService = HomeService(delegate: self);
        self.headerRefresh();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(headerRefresh), name: Notification.Name.UIApplicationWillEnterForeground, object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    override func headerRefresh() {
        self.homeService.getHome();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        
        //Banner
        if (self.homeService.bannerList != nil) {
            LotteryUtil.saveBannerList(bannerList: self.homeService.bannerList);
        }
        self.setBannerImageUrl();
        
        if (self.homeService.cornerBanner != nil) {
            LotteryUtil.saveCornerBanner(banner: self.homeService.cornerBanner);
        }
        self.redPacketButton.sd_setImage(with: CommonUtil.getURL(LotteryUtil.cornerBanner()?.imgUrl), for: .normal);
        
        //Entrance
        if (self.homeService.gameEntranceList != nil) {
           self.entranceList = self.homeService.gameEntranceList;
            LotteryUtil.saveHomeEntranceList(entranceList: self.entranceList);
        }
        
        //HotPeriod
//        self.quickOrderView.setData(hotTitle: self.homeService.hotTitle, hotTips: self.homeService.hotTips, hotPeriod: self.homeService.hotGamePeriod);
        
        self.loadSuccess();
        
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let urlContent = LotteryUtil.bannerList()?[index].detailUrl;
        if (urlContent != nil) {
            LotteryRoutes.routeURLString(urlContent!);

        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = self.entranceList.count/2;
        if (self.entranceList.count%2 != 0) {
            number = self.entranceList.count/2 + 1;
        }
        return number;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_WIDTH/4;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell;
        
        cell.leftItemView.setData(entrance: self.entranceList[indexPath.row*2]);
        cell.leftItemView.addTarget(self, action: #selector(navAction), for: .touchUpInside);
        if (indexPath.row*2 != self.entranceList.count-1) {
            cell.rightItemView.isHidden = false;
            cell.rightItemView.setData(entrance: self.entranceList[indexPath.row*2+1]);
            cell.rightItemView.addTarget(self, action: #selector(navAction), for: .touchUpInside);
        } else {
            cell.rightItemView.isHidden = true;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero;
        cell.layoutMargins = UIEdgeInsets.zero;
    }
    
    func navAction(_ button: HomeCellItemView) {
        if (button.contentUrl?.isEmpty != true) {
            var category = 1
            let urlSeparateArr = button.contentUrl?.components(separatedBy: "?")
            for separateUrl in urlSeparateArr! {
                if separateUrl.contains("category") {
                    let str = (separateUrl as NSString).substring(with: NSMakeRange(9, 1))
                    category = Int(String(str)!)!
                }
                
            }
            LotteryRoutes.routeURLString(button.contentUrl!, withParameters: ["gameName":button.lotteryTitleLabel.text!,"category":category]);
        } else {
            let alertController = UIAlertController(title: "敬请期待", message: nil, preferredStyle: .alert);
            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
            alertController.show();
        }
    }
    
    func setBannerImageUrl() {
        let bannerList = LotteryUtil.bannerList();
        var imageUrlList = Array<String>();
        if (bannerList != nil) {
            for banner in bannerList! {
                if (banner.imgUrl != nil) {
                    imageUrlList.append(banner.imgUrl!);
                }
            }
            self.cycleScrollView.imageURLStringsGroup = imageUrlList;
        }
    }
    
    func cornerBannerAction() {
        if (LotteryUtil.cornerBanner() != nil) {
            let urlContent = LotteryUtil.cornerBanner()?.detailUrl;
            if (urlContent != nil) {
               LotteryRoutes.routeURLString(urlContent!); 
            }
            
        }
    }
    
}
