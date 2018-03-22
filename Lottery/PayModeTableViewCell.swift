//
//  PayModeTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayModeTableViewCell: LotteryBaseTableViewCell {
    var descriptionLabel: UILabel!;
    var iconImageView : UIImageView!
    var titileLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        self.titileLabel = UILabel()
        self.titileLabel?.font = UIFont.systemFont(ofSize: 14);
        self.titileLabel?.textColor = COLOR_FONT_TEXT;
        self.titileLabel.frame = CGRect(x: 50, y: 5, width: SCREEN_WIDTH - 50, height: 30)
        self.iconImageView = UIImageView();
        self.iconImageView?.frame = CGRect(x:15, y: 5, width: 30, height: 30)
        self.descriptionLabel = UILabel();
        self.descriptionLabel.layer.borderWidth = 0.5;
        self.descriptionLabel.layer.borderColor = COLOR_RED.cgColor;
        self.descriptionLabel.textColor = COLOR_RED;
        self.descriptionLabel.font = self.textLabel?.font;
        self.addSubview(self.descriptionLabel);
        self.addSubview(self.iconImageView);
        self.addSubview(self.titileLabel);

    }
    
    func reloadCell(model:PayMethod,method:String){
        self.iconImageView?.sd_setImage(with: CommonUtil.getURL(model.imageUrl))

        self.iconImageView?.sd_setImage(with: CommonUtil.getURL(model.imageUrl), placeholderImage: nil, options: SDWebImageOptions(rawValue: UInt(1 << 8)))
        self.titileLabel?.text = model.name
        
        if method == model.paymethod {
            self.accessoryView = UIImageView(image: UIImage(named: "icon_selected"));
        }else{
            self.accessoryView = UIImageView(image: UIImage(named: "icon_unselected"));
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
