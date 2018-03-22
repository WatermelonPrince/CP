//
//  HomeCellItemView.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeDescriptionView: UIView {
    var imageView: UIImageView!;
    var label: UILabel!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height));
        let image = UIImage(named: "icon_home_description_background");
        image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15));
        self.imageView.image = image;
        self.addSubview(self.imageView);
        
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height));
        self.label.font = UIFont.systemFont(ofSize: K_FONT_SIZE*0.9);
        self.label.textColor = COLOR_WHITE;
        self.addSubview(self.label);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImageView() {
        self.label.sizeToFit();
        self.label.frame.size.height = self.frame.height;
        
        self.imageView.frame.size.width = self.label.frame.width + 20;
        self.imageView.frame.origin.y = 1;
        self.imageView.frame.size.height = self.frame.height - 2;
        
        
        self.label.frame.origin.x = 10;
        self.label.frame.size.width = self.frame.width - 10;
    }
}

class HomeCellItemView: UIButton {
    
    let kWidth = SCREEN_WIDTH/2;
    let kHeight = SCREEN_WIDTH/4;
    
    var lotteryImageView: UIImageView!;
    var lotteryTitleLabel: UILabel!;
    var lotteryDescriptionView: HomeDescriptionView!;
    var lotteryDescriptionLabel: UILabel!;
    var cornerImageView: UIImageView!;
    
    var contentUrl: String?;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_GROUND), for: .highlighted);
        
        //图片
        let lotteryImageViewHeight = kWidth/2-20*2 - 10;
        self.lotteryImageView = UIImageView(frame: CGRect(x: 15, y: 20, width: lotteryImageViewHeight, height: lotteryImageViewHeight));
        self.addSubview(self.lotteryImageView);
        
        //名称
        let lotteryLabelWidth = kWidth-15-self.lotteryImageView.frame.width-10;
        let lotteryLabelHeight = self.lotteryImageView.frame.height/2;
        self.lotteryTitleLabel = UILabel(frame: CGRect(x: self.lotteryImageView.frame.maxX + 10, y: self.lotteryImageView.frame.minY, width: lotteryLabelWidth, height: lotteryLabelHeight));
        self.lotteryTitleLabel.font = UIFont.boldSystemFont(ofSize: K_FONT_SIZE);
        self.lotteryTitleLabel.textColor = COLOR_FONT_TEXT;
        self.addSubview(self.lotteryTitleLabel);
        
        //描述View
        self.lotteryDescriptionView = HomeDescriptionView(frame: CGRect(x: self.lotteryTitleLabel.frame.minX, y: self.lotteryTitleLabel.frame.maxY+5, width: lotteryLabelWidth, height: lotteryLabelHeight));
        self.addSubview(self.lotteryDescriptionView);
        self.lotteryDescriptionView.isUserInteractionEnabled = false;
        self.lotteryDescriptionView.isHidden = true;
        
        //Label
        self.lotteryDescriptionLabel = UILabel(frame: CGRect(x: self.lotteryTitleLabel.frame.minX, y: self.lotteryTitleLabel.frame.maxY, width: lotteryLabelWidth, height: lotteryLabelHeight));
        self.lotteryDescriptionLabel.font = UIFont.systemFont(ofSize: 11);
        self.addSubview(self.lotteryDescriptionLabel);
        self.lotteryDescriptionLabel.isHidden = true;
        
        
        //CornerImageView
        self.cornerImageView = UIImageView(frame: CGRect(x: kWidth-10-kWidth*0.11, y: 10, width: kWidth*0.11, height: kWidth*0.11));
        self.addSubview(self.cornerImageView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(entrance: Entrance) {
        self.contentUrl = entrance.contentUrl;
        self.lotteryTitleLabel.text = entrance.title;
        if (entrance.tipsType == 1) {
            self.lotteryDescriptionLabel.textColor = COLOR_FONT_SECONDARY;
            self.lotteryDescriptionLabel.text = entrance.tips;
            self.lotteryDescriptionLabel.isHidden = false;
            self.lotteryDescriptionView.isHidden = true;
        } else if (entrance.tipsType == 2) {
            self.lotteryDescriptionLabel.textColor = COLOR_RED;
            self.lotteryDescriptionLabel.text = entrance.tips;
            self.lotteryDescriptionLabel.isHidden = false;
            self.lotteryDescriptionView.isHidden = true;
        } else {
            self.lotteryDescriptionView.label.text = entrance.tips;
            self.lotteryDescriptionView.resizeImageView();
            self.lotteryDescriptionView.isHidden = false;
            self.lotteryDescriptionLabel.isHidden = true;
        }
        self.lotteryImageView.sd_setImage(with: CommonUtil.getURL(entrance.imgUrl));
        self.cornerImageView.sd_setImage(with: CommonUtil.getURL(entrance.cornerImageUrl));
    }

}
