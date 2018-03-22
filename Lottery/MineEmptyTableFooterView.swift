//
//  MineEmptyTableFooterView.swift
//  Lottery
//
//  Created by DTY on 2017/5/5.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineEmptyTableFooterView: UIView {
    var emptyButton: UIButton!;
    var quickOrderView: HomeQuickOrderView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.emptyButton = UIButton(frame: CGRect(x: 0, y: 30, width: self.frame.width, height: 20));
        self.emptyButton.setTitleColor(COLOR_FONT_SECONDARY, for: .normal);
        self.emptyButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.emptyButton.contentHorizontalAlignment = .center;
        self.emptyButton.setTitle("点击重新加载", for: .normal)
        self.emptyButton.setTitle("暂无订单记录", for: .disabled);
        self.addSubview(self.emptyButton);
        
        
        self.quickOrderView = HomeQuickOrderView(frame: CGRect(x: 10, y: self.emptyButton.frame.maxY+60, width: self.frame.width-10*2, height: 100));
        self.quickOrderView.layer.borderColor = COLOR_BORDER.cgColor;
        self.quickOrderView.layer.borderWidth = 0.5;
//        self.addSubview(self.quickOrderView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
