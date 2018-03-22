//
//  D11NormalViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11NormalViewController: D11BaseViewController {
    var shakeButton: UIButton!;
    var prizeLabel: UILabel!;
    var minBalls = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //摇一摇机选
        let shakeButtonWidth = 120;
        let shakeButtonHeight = 120 * 96/324;
        self.shakeButton = UIButton(frame: CGRect(x: 0, y: 10, width: shakeButtonWidth, height: shakeButtonHeight));
        self.shakeButton.setImage(UIImage(named: "icon_board_shake"), for: .normal);
        self.scrollView.addSubview(self.shakeButton);
        self.shakeButton.addTarget(self, action: #selector(shakeAction), for: .touchUpInside);
        
        //DescriptionLabel
        self.descriptionLabel = D11BaseDescriptionLabel(frame: CGRect(x: 10, y: self.shakeButton.frame.maxY, width: self.view.frame.width-20*2, height: 30));
        self.scrollView.addSubview(self.descriptionLabel);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        self.shakeVibrateAction();
    }
    
}
