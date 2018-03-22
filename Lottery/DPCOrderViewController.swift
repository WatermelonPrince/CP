//
//  DPCOrderViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCOrderViewController: LotteryOrderViewController {
    var totalRedBalls = 0;
    var totalBlueBalls = 0;
    var minRedBalls = 0;
    var minBlueBalls = 0;
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func machineSelectionAction() {
        super.machineSelectionAction();
        self.insertRows(newArray: [LotteryUtil.randomStringDPCNormal(totalRed: self.totalRedBalls, minRed: self.minRedBalls, totalBlue: self.totalBlueBalls, minBlue: self.minBlueBalls)]);
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true);
        self.editedRow = indexPath.row;
        self.pushViewController(viewController: self.navController);
    }
    
    override func toCellDetailString(ballString: String) -> String {
        var descriptionString = "";
        let totalNumber = self.toOrderNumber(ballString: ballString);
        
        if (ballString.contains("(")) {
            descriptionString.append("胆拖");
        } else if (totalNumber > 1) {
            descriptionString.append("复式");
        } else {
            descriptionString.append("单式");
        }
        var amount = totalNumber*2;
        if (self.isAddNumber) {
            descriptionString.append("-追加");
            amount = totalNumber*3;
        }
        descriptionString.append(" \(totalNumber)注 \(amount)元");
        return descriptionString;
    }
    
    override func updateAmountInfo() {
        var orderNumber = 0;
        for string in ballStringArray {
            orderNumber = orderNumber + toOrderNumber(ballString: string);
        }
        var termNumber = 1;
        let termText = self.bottomMultipleBarView.mainView.termTextField.text;
        if (termText != nil && Int(termText!) != nil) {
            termNumber = Int(termText!)!;
        }
        var multipleNumber = 1;
        let multipleText = self.bottomMultipleBarView.mainView.multipleTextField.text;
        if (multipleText != nil && Int(multipleText!) != nil) {
            multipleNumber = Int(multipleText!)!;
        }
        var amount = orderNumber * termNumber * multipleNumber * 2;
        if (isAddNumber) {
            amount = orderNumber * termNumber * multipleNumber * 3;
        }
        
        self.bottomInfoBarView.setData(orderNumber: orderNumber, termNumer: termNumber, multipleNumer: multipleNumber, amount: amount);
    }
    
}
