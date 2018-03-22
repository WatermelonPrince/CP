//
//  LotteryBaseMagicViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseMagicViewController: VTMagicController {
    var menuTitles = Array<String>();
    var viewControllerList = Array<UIViewController>();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.magicView.frame.origin.y += 64;
        self.magicView.navigationColor = COLOR_WHITE;
        self.magicView.sliderColor = COLOR_RED;
        self.magicView.separatorColor = COLOR_BORDER;
        self.magicView.layoutStyle = .divide;
        self.magicView.switchStyle = .default;
        self.magicView.dataSource = self;
        self.magicView.delegate = self;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func menuTitles(for magicView: VTMagicView) -> [String] {
        let menuTitles = self.menuTitles;
        return menuTitles;
    }
    
    override func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton {
        var menuItem = magicView.dequeueReusableItem(withIdentifier: "itemIdentifier");
        if (menuItem == nil) {
            menuItem = UIButton(type: .custom);
            menuItem?.setTitleColor(COLOR_FONT_TEXT, for: .normal);
            menuItem?.setTitleColor(COLOR_RED, for: .selected);
            menuItem?.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            
        }
        return menuItem!;
    }
    
    override func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController {
        var vc = magicView.dequeueReusablePage(withIdentifier: "recom.identifier");
        if (vc == nil && self.viewControllerList.count != 0) {
            vc = self.viewControllerList[Int(pageIndex)];
        }
        
        if (vc == nil) {
            vc = LotteryBaseViewController();
        }
        
        return vc!;
    }

}
