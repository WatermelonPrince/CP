//
//  MineBasicInfoTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/5/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineBasicInfoTableViewController: LotteryBaseTableViewController, ServiceDelegate {
    var textField: UITextField!;
    var alertController: UIAlertController!;
    var userService: UserService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "基本信息";
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        
        self.userService = UserService(delegate: self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func onCompleteSuccess(service: BaseService) {
        let user = LotteryUtil.user();
        user?.name = self.textField.text;
        LotteryUtil.saveUser(user: user);
        self.tableView.reloadData();
        let vc = self.navigationController?.viewControllers.first as? MineViewController;
        vc?.headerView.setUser(user: user);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LotteryBaseTableViewCell(style: .value1, reuseIdentifier: nil);
        cell.accessoryType = .disclosureIndicator;
        if (indexPath.row == 0) {
            cell.textLabel?.text = "昵称";
            cell.detailTextLabel?.text = LotteryUtil.user()?.name;
        } else {
            cell.imageView?.sd_setImage(with: CommonUtil.getURL(LotteryUtil.user()?.avatar), placeholderImage: UIImage(named: "icon_avatar"));
            let itemSize = CGSize(width: 40, height: 40);
            UIGraphicsBeginImageContextWithOptions(itemSize, false, 0.0);
            let imageRect = CGRect(origin: CGPoint.zero, size: itemSize);
            cell.imageView?.image?.draw(in: imageRect);
            cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            cell.detailTextLabel?.text = "修改头像";
        }
    
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        if (indexPath.row == 0) {
            let alertController = UIAlertController(title: "修改昵称", message: nil, preferredStyle: .alert);
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入昵称";
                textField.text = LotteryUtil.user()?.name;
                NotificationCenter.default.addObserver(self, selector: #selector(self.alertTextFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                self.textField = textField;
            })
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
            alertController.addAction(UIAlertAction(title: "保存", style: .default, handler: { (action) in
                self.userService.commitInfo(name: self.textField.text!);
            }));
            self.alertController = alertController;
            alertController.show();
        }
        
    }
    
    func alertTextFieldDidChange(_ notification: Notification){
        let textField = notification.object as? UITextField;
        self.alertController.actions.last?.isEnabled = !(textField?.text?.isEmpty)!;
    }

}
