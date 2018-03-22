//
//  D11OrderBottomMultipleBarView.swift
//  Lottery
//
//  Created by DTY on 17/2/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11OrderBottomMultipleBarView: OrderBottomMultipleBarView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.mainView = D11OrderBottomMultipleBarMainView(frame: CGRect(x: 0, y: 40, width: self.frame.width, height: 40));
        self.termStopView = OrderBottomMultipleBarTermStopView(frame: self.mainView.frame);
        self.termView = D11OrderBottomMultipleBarTermView(frame: CGRect(x: 0, y: self.mainView.frame.maxY, width: self.frame.width, height: 40));
        self.multipleView = D11OrderBottomMultipleBarMultipleView(frame: self.termView.frame);
        
        self.setupView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
