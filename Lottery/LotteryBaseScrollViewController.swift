//
//  LotteryBaseScrollViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseScrollViewController: LotteryBaseViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = UIScrollView(frame: self.view.bounds);
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-64+1);
        self.view.addSubview(self.scrollView);
        self.scrollView.delegate = self;
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resignTextFieldAction));
        self.scrollView.addGestureRecognizer(tapGestureRecognizer);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.resignTextFieldAction();
    }
    
    func resignTextFieldAction() {
        for subview in scrollView.subviews {
            if (subview.isKind(of: LotteryBaseTextFieldView.classForCoder())) {
                for textField in subview.subviews {
                    if (textField.isKind(of: UITextField.classForCoder())) {
                        if (textField.isFirstResponder) {
                            textField.resignFirstResponder();
                            return;
                        }
                    }
                }
            }
        }
    }
    

}
