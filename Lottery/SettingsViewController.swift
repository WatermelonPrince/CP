//
//  SettingsViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/31.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SettingsViewController: LotteryBaseTableViewController {
    var shakeSwitch: UISwitch!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "设置";
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);

        //ShakeSwitch
        self.shakeSwitch = UISwitch();
        if (LotteryUtil.isEnabledShakeAction() == false) {
            self.shakeSwitch.isOn = false;
        } else {
            self.shakeSwitch.isOn = true;
        }
        self.shakeSwitch.addTarget(self, action: #selector(shakeSwitchAction), for: .valueChanged);
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func reloadTableView() {
        self.tableView.reloadData();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (LotteryUtil.isLogin()) {
            if (LotteryUtil.isWechatLogin() == true) {
                return 4;
            }
            return 5;
        }
        return 3;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20));
        view.backgroundColor = COLOR_GROUND;
        return view;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var section = section;
        if (tableView.numberOfSections == 3 || tableView.numberOfSections == 4) {
            section = section + 1;
        }
        
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            return 3;
        } else if (section == 3) {
            return 1;
        } else if (section == 4) {
            return 1;
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableViewCell();
        
        var indexPath = indexPath;
        if (tableView.numberOfSections == 3 || tableView.numberOfSections == 4) {
            indexPath.section = indexPath.section + 1;
        }
        
        if (indexPath.section == 0) {//Section 0
            if (indexPath.row == 0) {
                cell.imageView?.image = UIImage(named: "icon_settings_password");
                cell.textLabel?.text = "登陆密码设置";
                cell.accessoryType = .disclosureIndicator;
            }
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.selectionStyle = .none;
                cell.imageView?.image = UIImage(named: "icon_settings_shake");
                cell.textLabel?.text = "摇一摇机选";
                cell.accessoryView = self.shakeSwitch;
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.imageView?.image = UIImage(named: "icon_feedback");
                cell.textLabel?.text = "用户反馈";
                cell.accessoryType = .disclosureIndicator;
            }else if(indexPath.row == 1) {
                cell.imageView?.image = UIImage(named: "icon_settings_agreement");
                cell.textLabel?.text = "服务协议";
                cell.accessoryType = .disclosureIndicator;
            } else if (indexPath.row == 2) {
                cell.imageView?.image = UIImage(named: "icon_settings_about");
                cell.textLabel?.text = "关于我们";
                cell.accessoryType = .disclosureIndicator;
            }
        } else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                let cell = SettingsTableViewCell(style: .value1, reuseIdentifier: nil);
                cell.textLabel?.text = "清理缓存";
                var tempSize = Double(SDImageCache.shared().getSize())/Double(1024*1024);
                tempSize = tempSize + Double(XHLaunchAd.diskCacheSize());
                cell.detailTextLabel?.text = CommonUtil.formatDoubleString(double: tempSize) + "M";
                
                cell.accessoryType = .disclosureIndicator;
                return cell;
            }
        } else if (indexPath.section == 4) {
            cell.textLabel?.textAlignment = .center;
//            cell.textLabel?.textColor = COLOR_RED;
            cell.textLabel?.text = "退出登录";
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        var indexPath = indexPath;
        if (tableView.numberOfSections == 3 || tableView.numberOfSections == 4) {
            indexPath.section = indexPath.section + 1;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                let vc = ChangePasswordViewController();
                self.pushViewController(viewController: vc);
            }
        } else if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                let vc = FeedbackViewController();
                self.pushViewController(viewController: vc);
//                LotteryRoutes.routeURLString(HTTPConstants.AGREEMENT);
            }else if(indexPath.row == 1) {
                LotteryRoutes.routeURLString(HTTPConstants.AGREEMENT);
            } else if (indexPath.row == 2) {
                LotteryRoutes.routeURLString(HTTPConstants.ABOUT);
            }
        } else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
                alertController.addAction(UIAlertAction(title: "清理缓存", style: .destructive, handler: { (action) in
                    ViewUtil.showProgressToast(text: "正在清理");
                    XHLaunchAd.clearDiskCache();
                    SDImageCache.shared().clearMemory();
                    SDImageCache.shared().clearDisk(onCompletion: {
                        ViewUtil.dismissToast();
                        tableView.reloadData();
                    })
                }));
                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
                alertController.show();
                
            }
        } else if (indexPath.section == 4) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
            alertController.addAction(UIAlertAction(title: "退出登录", style: .destructive, handler: { (action) in
                LotteryUtil.clearLoginSession();
                tableView.reloadData();
                self.navigationController?.popViewController(animated: true);
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
                LotteryRoutes.routeLogin();
            }));
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            alertController.show();
        }
    }
    
    func shakeSwitchAction() {
        LotteryUtil.saveIsEnabledShakeAction(isOn: self.shakeSwitch.isOn);
    }
    
}
