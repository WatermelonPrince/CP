//
//  FeedbackViewController.swift
//  Lottery
//
//  Created by zhaohuan on 2017/8/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FeedbackViewController: LotteryBaseViewController, ServiceDelegate{
    var phoneTextField : UITextField?;
    var mailAddressTextField : UITextField?;
    var phoneLabel : UILabel?;
    var mailLabel : UILabel?;
    var adviceLabel : UILabel?;
    var adviceTextView : LotteryBaseTextView?;
    var feedbackService : FeedbackService!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "用户反馈";
        self.phoneLabel = UILabel();
        self.phoneLabel?.textColor = COLOR_BLACK;
        self.phoneLabel?.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width/7, height: 24);
        self.phoneLabel?.text = "手机号:";
        self.phoneLabel?.font = UIFont.systemFont(ofSize: 14);
        self.phoneTextField = UITextField(frame: CGRect(x: (self.phoneLabel?.frame.maxX)!, y: 0, width: self.view.frame.size.width - (self.phoneLabel?.frame.maxX)!, height: 44));
        self.phoneTextField?.placeholder = "请填写联系电话";
//        [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        self.phoneTextField?.setValue(UIFont.systemFont(ofSize: 14), forKeyPath: "_placeholderLabel.font");
        self.phoneTextField?.keyboardType = .phonePad;
        
        let lineview = UIView(frame: CGRect(x: 0, y: 44, width: self.view.frame.size.width, height: 0.5));
        lineview.backgroundColor = COLOR_BORDER;
        self.mailLabel = UILabel(frame: CGRect(x: (self.phoneLabel?.frame.minX)!, y: lineview.frame.midY + 10, width: self.view.frame.width/7, height: 24));
        self.mailLabel?.textColor = COLOR_BLACK;
        self.mailLabel?.text = "邮箱:";
        self.mailLabel?.font = UIFont.systemFont(ofSize: 14);
        self.mailAddressTextField = UITextField(frame: CGRect(x: (self.mailLabel?.frame.maxX)!, y: lineview.frame.midY, width: self.view.frame.size.width - (self.mailLabel?.frame.maxX)!, height: 44));
        self.mailAddressTextField?.placeholder = "请填写邮箱";
        self.mailAddressTextField?.setValue(UIFont.systemFont(ofSize: 14), forKeyPath: "_placeholderLabel.font");


        
        let bgView = UIView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 89));
        bgView.backgroundColor = COLOR_WHITE;
        bgView .addSubview(self.phoneLabel!);
        bgView.addSubview(self.phoneTextField!);
        bgView.addSubview(lineview);
        bgView.addSubview(self.mailLabel!);
        bgView.addSubview(self.mailAddressTextField!);
        
        self.adviceLabel = UILabel(frame: CGRect(x: 10, y: bgView.frame.maxY, width: self.view.frame.width/5, height: 44));
        self.adviceLabel?.textColor = COLOR_BLACK;
        self.adviceLabel?.font = UIFont.systemFont(ofSize: 14);
        self.adviceLabel?.text = "你的建议:";
        
        self.adviceTextView = LotteryBaseTextView(frame: CGRect(x: 0, y: (self.adviceLabel?.frame.maxY)!, width: self.view.frame.size.width, height: 200));
        self.adviceTextView?.placeholder = "遇到的BUG、建议、想要的功能、吐槽...";
        self.adviceTextView?.placeholderFont = UIFont.systemFont(ofSize: 14);
        self.adviceTextView?.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        self.adviceTextView?.backgroundColor = COLOR_WHITE;
        self.adviceTextView?.layer.borderWidth = 0.5;
        self.adviceTextView?.layer.borderColor = COLOR_BORDER.cgColor;
        self.adviceTextView?.layer.masksToBounds = true;
        self.view.addSubview(self.adviceLabel!);
        self.view.addSubview(self.adviceTextView!);
        self.view.addSubview(bgView);
        
        let item = UIBarButtonItem(title: "提交", style: .plain, target: self, action: #selector(submitAction));
        self.navigationItem.rightBarButtonItem = item;
        
        self.feedbackService = FeedbackService(delegate: self);

    }
    
    
    func submitAction(){
        if (self.adviceTextView?.text == nil || (self.adviceTextView?.text)! == "") {
            ViewUtil.showToast(text: "请填写你的建议");
            return;
        }
        self.feedbackService.commitFeedback(userId: (LotteryUtil.user()?.userId)!, mobile: self.phoneTextField?.text, name: nil, email: self.mailAddressTextField?.text, message: (self.adviceTextView?.text)!);
    }
    
    func onCompleteSuccess(service: BaseService) {
        self.navigationController?.popViewController(animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
