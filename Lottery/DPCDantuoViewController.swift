//
//  DPCDantuoViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/13.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCDantuoDescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_FONT_TEXT;
        self.font = UIFont.systemFont(ofSize: 14);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DPCDantuoViewController: DPCBaseViewController {
    var dantuoIntroButton: DantuoIntroButton!;

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.dantuoIntroButton = DantuoIntroButton(frame: CGRect(x: 10, y: 10, width: 15*7, height: 16));
        self.scrollView.addSubview(self.dantuoIntroButton);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
