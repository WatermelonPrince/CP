//
//  NewsListTableViewCell.swift
//  Lottery
//
//  Created by zhaohuan on 2017/7/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ArticleListTableViewCell: LotteryBaseTableViewCell {
    var titleLable: UILabel! //主标题
    var secondTitleLable: UILabel! //副标题
    var topLineView:UIView! //上分割线
    var lineView : UIView! //分割线
    let cellHeight = 72.0 as CGFloat
    let titleLabelHeight = 30 as CGFloat
    let secondLableHeight = 24 as CGFloat
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.titleLable = UILabel(frame: CGRect(x: 15, y: 15, width: SCREEN_WIDTH - 30, height: 15))
        self.titleLable.font = UIFont.systemFont(ofSize: 15)
        self.titleLable.textColor = HexColorTransform().transformFromJSON("#000000")
        self.secondTitleLable = UILabel(frame: CGRect(x: 15, y: self.titleLable.frame.maxY + 15, width: SCREEN_WIDTH - 30, height: 12))
        self.secondTitleLable.font = UIFont.systemFont(ofSize: 13)
        self.secondTitleLable.textColor = HexColorTransform().transformFromJSON("#65686E")
        //上分割线
        self.topLineView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
        self.topLineView.backgroundColor = #colorLiteral(red: 0.9097514573, green: 0.9097514573, blue: 0.9097514573, alpha: 1)
        self.topLineView.isHidden = true
        //分割线

        self.lineView = UIView(frame: CGRect(x: 0, y: cellHeight - 1, width: SCREEN_WIDTH, height: 1))
        self.lineView.backgroundColor = #colorLiteral(red: 0.9097514573, green: 0.9097514573, blue: 0.9097514573, alpha: 1)
        self.contentView .addSubview(self.titleLable)
        self.contentView .addSubview(self.secondTitleLable)
        self.contentView.addSubview(self.topLineView)
        self.contentView.addSubview(self.lineView)

    }
    
    func reloadCell(model:ArticleModel,indexPath:IndexPath){
        self.titleLable.text = model.title
        self.secondTitleLable.text = model.description
        if indexPath.row == 0 {
            self.topLineView.isHidden = false
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

}
