//
//  OrderBottomMultipleBarTermStopView.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class QuestionMarkButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.layer.cornerRadius = self.frame.width/2;
        self.layer.borderColor = COLOR_BLUE.cgColor;
        self.layer.borderWidth = 1;
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12);
        self.setTitle("?", for: .normal);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class OrderBottomMultipleBarTermStopView: UIView {
    var stopButton: LotteryCheckBoxButton!;
    var checkboxImageView: UIImageView!;
    var descriptionLabel: UILabel!;
    var questionMarkButton: QuestionMarkButton!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        self.stopButton = LotteryCheckBoxButton(frame: CGRect(x: 10, y: 11, width: 125, height: self.frame.height-11*2));
        self.addSubview(self.stopButton);
        self.stopButton.descriptionLabel.text = "中奖后停止追号";
        
        self.questionMarkButton = QuestionMarkButton(frame: CGRect(x: self.stopButton.frame.maxX + 5, y: self.stopButton.frame.minY + 2.5, width: self.stopButton.frame.height-5, height: self.stopButton.frame.height-5));
        self.addSubview(self.questionMarkButton);
        self.questionMarkButton.addTarget(self, action: #selector(questionMarkAction), for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func questionMarkAction() {
        let alertController = UIAlertController(title: "什么是中奖后停止追号", message: "勾选后，当您的追号方案某一期中奖，则后续的追号订单将被撤销，资金返还到您的账户中，如不勾选，系统一直帮您购买所有的追号投注订单", preferredStyle: .alert);
        let cancelAction = UIAlertAction(title: "我知道了", style: .cancel, handler: nil);
        alertController.addAction(cancelAction);
        alertController.show();
    }

}
