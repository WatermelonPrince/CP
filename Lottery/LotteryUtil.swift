//
//  LotteryUtil.swift
//  Lottery
//
//  Created by DTY on 17/2/4.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//单例模式创建的一些静态方法，包括一些本地配置存储

class LotteryUtil: NSObject {
    static let RENXUAN = "REN";
    static let QIAN_1 = "QIAN_1";
    static let QIAN_2_ZHIXUAN = "QIAN_2_ZHIXUAN";
    static let QIAN_2_ZUXUAN = "QIAN_2_ZUXUAN";
    static let QIAN_3_ZHIXUAN = "QIAN_3_ZHIXUAN";
    static let QIAN_3_ZUXUAN = "QIAN_3_ZUXUAN";
    
    //DPC
    static func dpcTypeToInt(type: DPCType) -> Int {
        if (type == .normal) {
            return 0;
        } else {
            return 1;
        }
    }
    
    static func randomStringDPCNormal(totalRed: Int, minRed: Int, totalBlue: Int, minBlue: Int) -> String {
        let randomRedIntArray = CommonUtil.randomIntArray(total: totalRed, count: minRed);
        let randomBlueIntArray = CommonUtil.randomIntArray(total: totalBlue, count: minBlue);
        let randomString = LotteryUtil.toBallStringDPCNormal(redBallArray: randomRedIntArray, blueBallArray: randomBlueIntArray);
        return randomString;
    }
    
    static func toBallStringDPCNormal(redBallArray: Array<Int>, blueBallArray: Array<Int>) -> String {
        var ballString = "";
        for number in redBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != redBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(":");
            }
        }
        for number in blueBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != blueBallArray.count-1) {
                ballString.append(" ");
            }
        }
        return ballString;
    }
    
    static func toBallIntArrayDPCNormal(string: String) -> [Array<Int>] {
        var content = string;
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var redBallArray = Array<Int>();
        var blueBallArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.element == ":") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                redBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element)
            } else {
                numString.append(char.element);
                blueBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [redBallArray, blueBallArray];
    }
    
    static func totalNumberDPCNormal(string: String, minRedBalls: Int, minBlueBalls: Int) -> Int{
        let redBallArray = LotteryUtil.toBallIntArrayDPCNormal(string: string)[0];
        let blueBallArray = LotteryUtil.toBallIntArrayDPCNormal(string: string)[1];
        let redBallNumber = redBallArray.count;
        let blueBallNumber = blueBallArray.count;
        let totalNumber = LotteryUtil.totalNumberDPCNormal(redBallNumber: redBallNumber, blueBallNumber: blueBallNumber, minRedBalls: minRedBalls, minBlueBalls: minBlueBalls);
        return totalNumber;
    }
    
    static func totalNumberDPCNormal(redBallNumber: Int, blueBallNumber: Int, minRedBalls: Int, minBlueBalls: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: redBallNumber, m: minRedBalls)*CommonUtil.calculateCombination(n: blueBallNumber, m: minBlueBalls);
        return totalNumber;
    }
    
    //SSQDantuo
    static func toBallStringSSQDantuo(danRedBallArray: Array<Int>, tuoRedBallArray: Array<Int>, blueBallArray: Array<Int>) -> String {
        var ballString = "(";
        
        for number in danRedBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != danRedBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(")");
            }
        }
        
        for number in tuoRedBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != tuoRedBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(":");
            }
        }
        
        for number in blueBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != blueBallArray.count-1) {
                ballString.append(" ");
            }
        }
        return ballString;
    }
    
    static func toBallIntArraySSQDantuo(string: String) -> [Array<Int>] {
        var content = string;
        content = content.replacingOccurrences(of: " ", with: "");
        content = content.replacingOccurrences(of: "(", with: "");
        var numString = "";
        var danRedBallArray = Array<Int>();
        var tuoRedBallArray = Array<Int>();
        var blueBallArray = Array<Int>();
        
        for char in content.characters.enumerated() {
            if (char.element == ")") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                danRedBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.element == ":") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                tuoRedBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element)
            } else {
                numString.append(char.element);
                blueBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [danRedBallArray, tuoRedBallArray, blueBallArray];
    }
    
    static func totalNumberSSQDantuo(string: String) -> Int{
        let danRedBallArray = LotteryUtil.toBallIntArraySSQDantuo(string: string)[0];
        let tuoRedBallArray = LotteryUtil.toBallIntArraySSQDantuo(string: string)[1];
        let blueBallArray = LotteryUtil.toBallIntArraySSQDantuo(string: string)[2];
        let danRedBallNumber = danRedBallArray.count;
        let tuoRedBallNumber = tuoRedBallArray.count;
        let blueBallNumber = blueBallArray.count;
        let totalNumber = LotteryUtil.totalNumberSSQDantuo(danRedBallNumber: danRedBallNumber, tuoRedBallNumber: tuoRedBallNumber, blueBallNumber: blueBallNumber);
        return totalNumber;
    }
    
    static func totalNumberSSQDantuo(danRedBallNumber: Int, tuoRedBallNumber: Int,blueBallNumber: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: tuoRedBallNumber, m: 6-danRedBallNumber)*CommonUtil.calculateCombination(n: blueBallNumber, m: 1);
        return totalNumber;
    }
    
    //DLTDantuo
    static func toBallStringDLTDantuo(danRedBallArray: Array<Int>, tuoRedBallArray: Array<Int>, danBlueBallArray: Array<Int>, tuoBlueBallArray: Array<Int>) -> String {
        var ballString = "(";
        
        for number in danRedBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != danRedBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(")");
            }
        }
        
        for number in tuoRedBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != tuoRedBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(":");
            }
        }
        
        ballString.append("(");
        
        for number in danBlueBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != danBlueBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(")");
            }
        }
        
        for number in tuoBlueBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != tuoBlueBallArray.count-1) {
                ballString.append(" ");
            }
        }
        return ballString;
    }
    
    static func toBallIntArrayDLTDantuo(string: String) -> [Array<Int>] {
        var content = string;
        content = content.replacingOccurrences(of: " ", with: "");
        content = content.replacingOccurrences(of: "(", with: "");
        var numString = "";
        var danRedBallArray = Array<Int>();
        var tuoRedBallArray = Array<Int>();
        var blueDanBallArray = Array<Int>();
        var blueTuoBallArray = Array<Int>();
        
        for char in content.characters.enumerated() {
            if (char.element == ")") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                danRedBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.element == ":") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                tuoRedBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.element == ")") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            
            if (char.offset % 2 == 0) {
                numString.append(char.element)
            } else {
                numString.append(char.element);
                blueDanBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element)
            } else {
                numString.append(char.element);
                blueTuoBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [danRedBallArray, tuoRedBallArray, blueDanBallArray, blueTuoBallArray];
    }
    
    static func totalNumberDLTDantuo(string: String) -> Int{
        let danRedBallArray = LotteryUtil.toBallIntArrayDLTDantuo(string: string)[0];
        let tuoRedBallArray = LotteryUtil.toBallIntArrayDLTDantuo(string: string)[1];
        let danBlueBallArray = LotteryUtil.toBallIntArrayDLTDantuo(string: string)[2];
        let tuoBlueBallArray = LotteryUtil.toBallIntArrayDLTDantuo(string: string)[3];
        let danRedBallNumber = danRedBallArray.count;
        let tuoRedBallNumber = tuoRedBallArray.count;
        let danBlueBallNumber = danBlueBallArray.count;
        let tuoBlueBallNumber = tuoBlueBallArray.count;
        let totalNumber = LotteryUtil.totalNumberDLTDantuo(danRedBallNumber: danRedBallNumber, tuoRedBallNumber: tuoRedBallNumber, danBlueBallNumber: danBlueBallNumber, tuoBlueBallNumber: tuoBlueBallNumber);
        return totalNumber;
    }
    
    static func totalNumberDLTDantuo(danRedBallNumber: Int, tuoRedBallNumber: Int, danBlueBallNumber: Int, tuoBlueBallNumber: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: tuoRedBallNumber, m: 5-danRedBallNumber)*CommonUtil.calculateCombination(n: tuoBlueBallNumber, m: 2-danBlueBallNumber);
        return totalNumber;
    }
    
    //D11
    static func toDescriptionAttString(subString: String, prizeContent: String) -> NSMutableAttributedString{
        let subAttString = NSMutableAttributedString(string: subString);
        let prizeAttString = NSMutableAttributedString(string: prizeContent, attributes: [NSForegroundColorAttributeName:COLOR_RED]);
        let yuanAttString = NSMutableAttributedString(string:"元");
        
        let attString = NSMutableAttributedString();
        attString.append(subAttString);
        attString.append(prizeAttString);
        attString.append(yuanAttString);
        
        return attString;
    }
    
    static func selectedIntToD11Type(int: Int) -> D11Type {
        if (int < 7) {
            return LotteryUtil.intToD11RenxuanType(int:int+2);
        } else if (int == 7) {
            return D11Type.qian1;
        } else if (int == 8) {
            return D11Type.qian2Zhixuan;
        } else if (int == 9) {
            return D11Type.qian2Zuxuan;
        } else if (int == 10) {
            return D11Type.qian3Zhixuan;
        } else if (int == 11) {
            return D11Type.qian3Zuxuan;
        } else if (int < 19) {
            return LotteryUtil.intToD11RenxuanType(int:int-10);
        } else if (int == 19) {
            return D11Type.qian2Zuxuan;
        } else if (int == 20) {
            return D11Type.qian3Zuxuan;
        }
        return D11Type.renxuan2;
    }
    
    
    //D11Renxuan
    static func intToD11RenxuanType(int: Int) -> D11Type{
        if (int == 2) {
            return .renxuan2;
        } else if (int == 3) {
            return .renxuan3;
        } else if (int == 4) {
            return .renxuan4;
        } else if (int == 5) {
            return .renxuan5;
        } else if (int == 6) {
            return .renxuan6;
        } else if (int == 7) {
            return .renxuan7;
        } else if (int == 8) {
            return .renxuan8;
        } else {
            return .renxuan2
        }
    }
    
    static func d11RenxuanTypeToInt(type: D11Type) -> Int {
        var int = Int(String(describing: String(describing: type).characters.last!));
        if (int == nil) {
            int = 2;
        }
        return int!;
    }
    
    static func d11MinBallsToPrizeContent(minBalls: Int) -> String {
        if (minBalls == 2) {
            return "6";
        } else if (minBalls == 3) {
            return "19";
        } else if (minBalls == 4) {
            return "78";
        } else if (minBalls == 5) {
            return "540";
        } else if (minBalls == 6) {
            return "90";
        } else if (minBalls == 7) {
            return "26";
        } else if (minBalls == 8) {
            return "9";
        }
        
        return "0";
    }
    
    static func randomStringD11Renxuan(minBalls: Int) -> String {
        let randomIntArray = CommonUtil.randomIntArray(total: 11, count: minBalls);
        let randomString = LotteryUtil.toBallStringD11Renxuan(ballArray: randomIntArray, minBalls: minBalls);
        return randomString;
    }
    
    static func toBallStringD11Renxuan (ballArray: Array<Int>, minBalls: Int) -> String {
        var ballString = "";
        for number in ballArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != ballArray.count-1) {
                ballString.append(" ");
            }
        }
        //D11Type
        ballString = ballString + "[\(RENXUAN)_\(minBalls)]";
        return ballString;
    }
    
    static func toBallIntArrayD11Renxuan(string: String) -> Array<Int> {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var ballArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                ballArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return ballArray;
    }
    
    static func totalNumberD11Renxuan(string: String, minBalls: Int) -> Int{
        let ballArray = LotteryUtil.toBallIntArrayD11Renxuan(string: string);
        let ballNumber = ballArray.count;
        let totalNumber = LotteryUtil.totalNumberD11Renxuan(ballNumber: ballNumber, minBalls: minBalls);
        return totalNumber;
    }
    
    static func totalNumberD11Renxuan(ballNumber: Int, minBalls: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: ballNumber, m: minBalls);
        return totalNumber;
    }
    
    //D11Qian1
    static func randomStringD11Qian1() -> String {
        let randomIntArray = CommonUtil.randomIntArray(total: 11, count: 1);
        let randomString = LotteryUtil.toBallStringD11Qian1(ballArray: randomIntArray);
        return randomString;
    }
    
    static func toBallStringD11Qian1 (ballArray: Array<Int>) -> String {
        var ballString = "";
        for number in ballArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != ballArray.count-1) {
                ballString.append(" ");
            }
        }
        
        //D11Type
        ballString = ballString + "[\(QIAN_1)]";
        
        return ballString;
    }
    
    static func toBallIntArrayD11Qian1(string: String) -> Array<Int> {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var ballArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                ballArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return ballArray;
    }
    
    static func totalNumberD11Qian1(string: String) -> Int{
        let ballArray = LotteryUtil.toBallIntArrayD11Qian1(string: string);
        let ballNumber = ballArray.count;
        let totalNumber = LotteryUtil.totalNumberD11Qian1(ballNumber: ballNumber);
        return totalNumber;
    }
    
    static func totalNumberD11Qian1(ballNumber: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: ballNumber, m: 1);
        return totalNumber;
    }
    
    //D11Qian2Zhixuan
    static func randomIntArrayListD11Qian2Zhixuan() -> [Array<Int>] {
        let randomWanArray = CommonUtil.randomIntArray(total: 11, count: 1);
        var randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        while (randomWanArray[0] == randomQianArray[0]) {
            randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        }
        return [randomWanArray, randomQianArray];
    }
    
    static func randomStringD11Qian2Zhixuan() -> String {
        let randomIntArrayList = LotteryUtil.randomIntArrayListD11Qian2Zhixuan();
        let randomStringArray = LotteryUtil.toBallStringD11Qian2Zhixuan(wanBallNumberArray: randomIntArrayList[0], qianBallNumberArray: randomIntArrayList[1]);
        let randomString = randomStringArray[0];
        return randomString;
    }
    
    static func toBallStringD11Qian2Zhixuan (wanBallNumberArray: Array<Int>, qianBallNumberArray: Array<Int>) -> Array<String> {
        
        var hasMutualBall = false;
        hasMutualBall = CommonUtil.hasMutualInt(intArrayList: [wanBallNumberArray, qianBallNumberArray]);
        
        var ballStringArray = Array<String>();
        if (hasMutualBall == false) {//没有相同的球
            var ballString = "";
            for number in wanBallNumberArray.enumerated() {
                ballString.append(CommonUtil.toBallNumberString(i: number.element));
                if (number.offset != wanBallNumberArray.count-1) {
                    ballString.append(" ");
                } else {
                    ballString.append("|");
                }
            }
            
            for number in qianBallNumberArray.enumerated() {
                ballString.append(CommonUtil.toBallNumberString(i: number.element));
                if (number.offset != qianBallNumberArray.count-1) {
                    ballString.append(" ");
                }
            }
            
            //D11Type
            ballString = ballString + "[\(QIAN_2_ZHIXUAN)]";
            
            ballStringArray.append(ballString);
        } else {//有相同的球
            for wanNumber in wanBallNumberArray {
                for qianNumber in qianBallNumberArray {
                    if (wanNumber != qianNumber) {
                        var ballString = CommonUtil.toBallNumberString(i: wanNumber) + "|" + CommonUtil.toBallNumberString(i: qianNumber);
                        
                        //D11Type
                        ballString = ballString + "[\(QIAN_2_ZHIXUAN)]";
                        
                        ballStringArray.append(ballString);
                    }
                }
            }
            
        }
        
        return ballStringArray;
    }
    
    static func toBallIntArrayD11Qian2Zhixuan(string: String) -> [Array<Int>] {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var wanBallArray = Array<Int>();
        var qianBallArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.element == "|") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                wanBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                qianBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [wanBallArray, qianBallArray];
    }
    
    static func mutualNumberD11Qian2Zhixuan(wanBallArray: Array<Int>, qianBallArray: Array<Int>) -> Int {
        var mutualBallNumber = 0;
        for wanNumber in wanBallArray {
            for qianNumber in qianBallArray {
                if (wanNumber == qianNumber) {
                    mutualBallNumber += 1;
                }
            }
        }
        return mutualBallNumber;
    }
    
    static func totalNumberD11Qian2Zhixuan(string: String) -> Int{
        let ballArrayList = LotteryUtil.toBallIntArrayD11Qian2Zhixuan(string: string);
        let wanBallArray = ballArrayList[0];
        let qianBallArray = ballArrayList[1];
        let wanBallNumber = wanBallArray.count;
        let qianBallNumber = qianBallArray.count;
        
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian2Zhixuan(wanBallArray: wanBallArray, qianBallArray: qianBallArray);
        let totalNumber = LotteryUtil.totalNumberD11Qian2Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber, mutualBallNumber: mutualBallNumber);
        return totalNumber;
    }
    
    static func totalNumberD11Qian2Zhixuan(wanBallNumber: Int, qianBallNumber: Int, mutualBallNumber: Int) -> Int {
        let totalNumber = wanBallNumber * qianBallNumber - mutualBallNumber;
        return totalNumber;
    }
    
    //D11Zuxuan
    static func randomStringD11Zuxuan(minBalls: Int) -> String {
        let randomIntArray = CommonUtil.randomIntArray(total: 11, count: minBalls);
        let randomString = LotteryUtil.toBallStringD11Zuxuan(ballArray: randomIntArray, minBalls: minBalls);
        return randomString;
    }
    
    static func toBallStringD11Zuxuan (ballArray: Array<Int>, minBalls: Int) -> String {
        var ballString = "";
        for number in ballArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != ballArray.count-1) {
                ballString.append(" ");
            }
        }
        
        //D11Type
        var d11Type = QIAN_2_ZUXUAN;
        if (minBalls == 3) {
            d11Type = QIAN_3_ZUXUAN;
        }
        ballString = ballString + "[\(d11Type)]";
        
        return ballString;
    }
    
    static func toBallIntArrayD11Zuxuan(string: String) -> Array<Int> {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var ballArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                ballArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return ballArray;
    }
    
    static func totalNumberD11Zuxuan(string: String) -> Int{
        var minBalls = 2;
        if (string.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
            minBalls = 3;
        }
        let ballArray = LotteryUtil.toBallIntArrayD11Zuxuan(string: string);
        let ballNumber = ballArray.count;
        let totalNumber = LotteryUtil.totalNumberD11Zuxuan(ballNumber: ballNumber, minBalls: minBalls);
        return totalNumber;
    }
    
    static func totalNumberD11Zuxuan(ballNumber: Int, minBalls: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: ballNumber, m: minBalls);
        return totalNumber;
    }
    
    //D11Qian3Zhixuan
    static func randomIntArrayListD11Qian3Zhixuan() -> [Array<Int>] {
        let randomWanArray = CommonUtil.randomIntArray(total: 11, count: 1);
        var randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        while (randomWanArray[0] == randomQianArray[0]) {
            randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        }
        var randomBaiArray = CommonUtil.randomIntArray(total: 11, count: 1);
        while (randomBaiArray[0] == randomQianArray[0] || randomBaiArray[0] == randomWanArray[0]) {
            randomBaiArray = CommonUtil.randomIntArray(total: 11, count: 1);
        }
        return [randomWanArray, randomQianArray, randomBaiArray];
    }
    
    static func randomStringD11Qian3Zhixuan() -> String {
        let randomIntArrayList = LotteryUtil.randomIntArrayListD11Qian3Zhixuan();
        let randomStringArray = LotteryUtil.toBallStringD11Qian3Zhixuan(wanBallNumberArray: randomIntArrayList[0], qianBallNumberArray: randomIntArrayList[1], baiBallNumberArray: randomIntArrayList[2]);
        let randomString = randomStringArray[0];
        return randomString;
    }
    
    static func toBallStringD11Qian3Zhixuan (wanBallNumberArray: Array<Int>, qianBallNumberArray: Array<Int>, baiBallNumberArray: Array<Int>) -> Array<String> {
        
        var hasMutualBall = false;
        hasMutualBall = CommonUtil.hasMutualInt(intArrayList: [wanBallNumberArray, qianBallNumberArray, baiBallNumberArray]);
        
        var ballStringArray = Array<String>();
        if (hasMutualBall == false) {//没有相同的球
            var ballString = "";
            for number in wanBallNumberArray.enumerated() {
                ballString.append(CommonUtil.toBallNumberString(i: number.element));
                if (number.offset != wanBallNumberArray.count-1) {
                    ballString.append(" ");
                } else {
                    ballString.append("|");
                }
            }
            
            for number in qianBallNumberArray.enumerated() {
                ballString.append(CommonUtil.toBallNumberString(i: number.element));
                if (number.offset != qianBallNumberArray.count-1) {
                    ballString.append(" ");
                } else {
                    ballString.append("|");
                }
            }
            
            for number in baiBallNumberArray.enumerated() {
                ballString.append(CommonUtil.toBallNumberString(i: number.element));
                if (number.offset != baiBallNumberArray.count-1) {
                    ballString.append(" ");
                }
            }
            
            //D11Type
            ballString = ballString + "[\(QIAN_3_ZHIXUAN)]";
            
            ballStringArray.append(ballString);
        } else {//有相同的球
            for wanNumber in wanBallNumberArray {
                for qianNumber in qianBallNumberArray {
                    for baiNumber in baiBallNumberArray {
                        if (wanNumber != qianNumber && wanNumber != baiNumber && qianNumber != baiNumber) {
                            var ballString = CommonUtil.toBallNumberString(i: wanNumber) + "|" + CommonUtil.toBallNumberString(i: qianNumber) + "|" + CommonUtil.toBallNumberString(i: baiNumber);
                            //D11Type
                            ballString = ballString + "[\(QIAN_3_ZHIXUAN)]";
                            
                            ballStringArray.append(ballString);
                        }
                    }
                }
            }
            
        }
        
        return ballStringArray;
    }
    
    static func toBallIntArrayD11Qian3Zhixuan(string: String) -> [Array<Int>] {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        var numString = "";
        var wanBallArray = Array<Int>();
        var qianBallArray = Array<Int>();
        var baiBallArray = Array<Int>();
        for char in content.characters.enumerated() {
            if (char.element == "|") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                wanBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.element == "|") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                qianBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                baiBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [wanBallArray, qianBallArray, baiBallArray];
    }
    
    static func mutualNumberD11Qian3Zhixuan(wanBallArray: Array<Int>, qianBallArray: Array<Int>, baiBallArray: Array<Int>) -> Int {
        var mutualBallNumber = 0;
        for wanNumber in wanBallArray {
            for qianNumber in qianBallArray {
                for baiNumber in baiBallArray {
                    if (wanNumber == qianNumber || wanNumber == baiNumber || qianNumber == baiNumber) {
                        mutualBallNumber += 1;
                    }
                }
            }
        }
        return mutualBallNumber;
    }
    
    static func totalNumberD11Qian3Zhixuan(string: String) -> Int{
        let ballArrayList = LotteryUtil.toBallIntArrayD11Qian3Zhixuan(string: string);
        let wanBallArray = ballArrayList[0];
        let qianBallArray = ballArrayList[1];
        let baiBallArray = ballArrayList[2];
        let wanBallNumber = wanBallArray.count;
        let qianBallNumber = qianBallArray.count;
        let baiBallNumber = baiBallArray.count;
        
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian3Zhixuan(wanBallArray: wanBallArray, qianBallArray: qianBallArray, baiBallArray: baiBallArray);
        
        let totalNumber = LotteryUtil.totalNumberD11Qian3Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber, baiBallNumber: baiBallNumber,mutualBallNumber: mutualBallNumber);
        return totalNumber;
    }
    
    static func totalNumberD11Qian3Zhixuan(wanBallNumber: Int, qianBallNumber: Int, baiBallNumber: Int,mutualBallNumber: Int) -> Int {
        let totalNumber = wanBallNumber * qianBallNumber * baiBallNumber - mutualBallNumber;
        return totalNumber;
    }
    
    //D11Dantuo
    static func toBallStringD11Dantuo(danBallArray: Array<Int>, tuoBallArray: Array<Int>) -> String {
        var ballString = "(";
        
        for number in danBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != danBallArray.count-1) {
                ballString.append(" ");
            } else {
                ballString.append(")");
            }
        }
        
        for number in tuoBallArray.enumerated() {
            ballString.append(CommonUtil.toBallNumberString(i: number.element));
            if (number.offset != tuoBallArray.count-1) {
                ballString.append(" ");
            }
        }
        
        return ballString;
    }
    
    static func toBallIntArrayD11Dantuo(string: String) -> [Array<Int>] {
        var content = string;
        
        //D11Type
        content = CommonUtil.subStringFromChar(string: content, character: "[");
        
        content = content.replacingOccurrences(of: " ", with: "");
        content = content.replacingOccurrences(of: "(", with: "");
        var numString = "";
        var danBallArray = Array<Int>();
        var tuoBallArray = Array<Int>();
        
        for char in content.characters.enumerated() {
            if (char.element == ")") {
                content = content.substring(from: content.index(content.startIndex, offsetBy: char.offset+1));
                break;
            }
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                danBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        for char in content.characters.enumerated() {
            
            if (char.offset % 2 == 0) {
                numString.append(char.element);
            } else {
                numString.append(char.element);
                tuoBallArray.append(Int(numString)!);
                numString = "";
            }
        }
        
        return [danBallArray, tuoBallArray];
    }
    
    static func totalNumberD11Dantuo(string: String, minBalls: Int) -> Int{
        let danBallArray = LotteryUtil.toBallIntArrayD11Dantuo(string: string)[0];
        let tuoBallArray = LotteryUtil.toBallIntArrayD11Dantuo(string: string)[1];
        let danBallNumber = danBallArray.count;
        let tuoBallNumber = tuoBallArray.count;
        let totalNumber = LotteryUtil.totalNumberD11Dantuo(danBallNumber: danBallNumber, tuoBallNumber: tuoBallNumber, minBalls: minBalls);
        return totalNumber;
    }
    
    static func totalNumberD11Dantuo(danBallNumber: Int, tuoBallNumber: Int, minBalls: Int) -> Int{
        let totalNumber = CommonUtil.calculateCombination(n: tuoBallNumber, m: minBalls-danBallNumber);
        return totalNumber;
    }
    
    //D11DantuoRenxuan
    static func toBallStringD11RenxuanDantuo(danBallArray: Array<Int>, tuoBallArray: Array<Int>, minBalls: Int) -> String {
        var ballString = LotteryUtil.toBallStringD11Dantuo(danBallArray: danBallArray, tuoBallArray: tuoBallArray);
        ballString = ballString + "[\(RENXUAN)_\(minBalls)]"
        
        return ballString;
    }
    //D11DantuoZuxuan
    static func toBallStringD11ZuxuanDantuo(danBallArray: Array<Int>, tuoBallArray: Array<Int>, minBalls: Int) -> String {
        var d11TypeString = QIAN_2_ZUXUAN;
        if (minBalls == 3) {
            d11TypeString = QIAN_3_ZUXUAN;
        }
        var ballString = LotteryUtil.toBallStringD11Dantuo(danBallArray: danBallArray, tuoBallArray: tuoBallArray);
        ballString = ballString + "[\(d11TypeString)]"
        
        return ballString;
    }
    
    //DeadlineContent
    static func getDeadlineContent(timeInterval: TimeInterval, subPeriod: String?) -> NSAttributedString {
        var attText = NSMutableAttributedString();
        
        if (timeInterval == MAX_TIME_INTERVAL) {
            attText = NSMutableAttributedString(string: "正在获取期次信息...");
        } else if (timeInterval == 0) {
            attText = NSMutableAttributedString(string: "当前期次已截止，请等待下期...");
        } else if (timeInterval == -1) {
            attText = NSMutableAttributedString(string: "点击重新获取期次信息");
        } else {
            let timeString = CommonUtil.mSStringFromTimeInterval(timeInterval: timeInterval);
            var subPeriod = subPeriod;
            if (subPeriod == nil) {
                subPeriod = "--";
            }
            attText = NSMutableAttributedString(string: "距\(subPeriod!)期截止：");
            var numberAttText = NSMutableAttributedString();
            if (timeInterval >= 60) {
                numberAttText = NSMutableAttributedString(string: timeString, attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.systemFont(ofSize: 15)]);
            } else {
                numberAttText = NSMutableAttributedString(string: timeString, attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)]);
            }
            attText.append(numberAttText);
        }
        return attText;
    }
    
    //保存读取List
    static func selectionList(gameEn: String) -> Dictionary<String, Any>? {
        let object = CommonUtil.getStorageVariable(forKey: "save_list_\(gameEn)") as? Dictionary<String, Any>;
        return object;
    }
    
    static func saveSelectionList(list: Array<String>, term: Int, isTermStop: Bool, multiple: Int, isAddNumber: Bool ,gameEn: String) {
        var dict = Dictionary<String,Any>();
        dict["list"] = list;
        dict["term"] = term;
        dict["isTermStop"] = isTermStop;
        dict["multiple"] = multiple;
        dict["isAddNumber"] = isAddNumber;
        CommonUtil.setStorageVariable(dict, forKey: "save_list_\(String(describing: gameEn))");
    }
    
    static func removeSelectionList(gameEn: String) {
        CommonUtil.removeUserDefaults(forKey: "save_list_\(gameEn)");
    }
    
    //保存读取Type
    static func lotterySelectedTypeInt(gameEn: String) -> Int? {
        let object = CommonUtil.getStorageVariable(forKey: "save_int_\(gameEn)") as? Int;
        return object;
    }
    
    static func saveLotterySelectedTypeInt(gameEn: String, selectedInt: Int) {
        CommonUtil.setStorageVariable(selectedInt, forKey: "save_int_\(gameEn)");
    }
    
    //保存读取ShakeAction
    static func isEnabledShakeAction() -> Bool? {
        let object = CommonUtil.getStorageVariable(forKey: "save_isEnabledShakeAction") as? Bool;
        return object;
    }
    
    static func saveIsEnabledShakeAction(isOn: Bool) {
        CommonUtil.setStorageVariable(isOn, forKey: "save_isEnabledShakeAction");
    }
    
    //保存读取Banner
    static func bannerList() -> Array<Banner>? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_bannerList") as? String;
        let object = [Banner].deserialize(from: jsonString) as? Array<Banner>;
        return object;
    }
    
    static func saveBannerList(bannerList: Array<Banner>) {
        let jsonString = bannerList.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_bannerList");
    }
    
    //保存读取CornerBanner
    static func cornerBanner() -> Banner? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_cornerBanner") as? String;
        let object = Banner.deserialize(from: jsonString);
        return object;
    }
    
    static func saveCornerBanner(banner: Banner) {
        let jsonString = banner.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_cornerBanner");
    }
    
    //保存读取HomeEntranceList
    static func homeEntranceList() -> Array<Entrance>? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_homeEntranceList") as? String;
        let object = [Entrance].deserialize(from: jsonString) as? Array<Entrance>;
        return object;
    }
    
    static func saveHomeEntranceList(entranceList: Array<Entrance>) {
        let jsonString = entranceList.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_homeEntranceList");
        
    }
    
    //保存读取newList咨询新闻列表
    static func articleListAticleList(category:Int)->Array<ArticleModel>?{
        let str = "save_newList_\(category)"
        let jsonString = CommonUtil.getStorageVariable(forKey: str) as? String;
        let object = [ArticleModel].deserialize(from: jsonString) as? Array<ArticleModel>
        return object
    }
    
    static func saveArticleList(articleList:Array<ArticleModel>,category:Int){
        let jsonString = articleList.toJSONString();
        let str = "save_newList_\(category)"
        CommonUtil.setStorageVariable(jsonString, forKey: str)
    }
    
    //保存读取Notice
    static func awardInfoList() -> Array<AwardInfo>? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_awardInfoList") as? String;
        let object = [AwardInfo].deserialize(from: jsonString) as? Array<AwardInfo>;
        return object;
    }
    
    static func saveAwardInfoList(awardInfoList: Array<AwardInfo>) {
        let jsonString = awardInfoList.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_awardInfoList");
    }
    
    //保存读取appId
    static func appId() -> String? {
        let object = CommonUtil.getStorageVariable(forKey: AppContext.APP_ID) as? String;
        return object;
    }
    
    static func saveAppId(appId: String?) {
        CommonUtil.setStorageVariable(appId, forKey: AppContext.APP_ID);
    }
    
    //保存读取appKey
    static func appKey() -> String? {
        let object = CommonUtil.getStorageVariable(forKey: AppContext.APP_KEY) as? String;
        return object;
    }
    
    static func saveAppKey(appKey: String?) {
        CommonUtil.setStorageVariable(appKey, forKey: AppContext.APP_KEY);
    }
    
    //保存读取token
    static func token() -> String? {
        let object = CommonUtil.getStorageVariable(forKey: AppContext.TOKEN) as? String;
        return object;
    }
    
    static func saveToken(token: String?) {
        CommonUtil.setStorageVariable(token, forKey: AppContext.TOKEN);
    }
    
    //保存读取user
    static func user() -> User? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_userInfo") as? String;
        let object = User.deserialize(from: jsonString);
        return object;
    }
    
    static func saveUser(user: User?) {
        let jsonString = user?.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_userInfo");
    }
    
    //保存读取LaunchAd
    static func launchAd() -> Banner? {
        let jsonString = CommonUtil.getStorageVariable(forKey: "save_launchAd") as? String;
        let object = Banner.deserialize(from: jsonString);
        return object;
    }
    
    static func saveLaunchAd(launchAd: Banner?) {
        let jsonString = launchAd?.toJSONString();
        CommonUtil.setStorageVariable(jsonString, forKey: "save_launchAd");
    }
    
    //保存读取登录方式
    static func isWechatLogin() -> Bool? {
        let object = CommonUtil.getStorageVariable(forKey: "save_isWechatLogin") as? Bool;
        return object;
    }
    
    static func saveIsWechatLogin(isWechatLogin: Bool?) {
        CommonUtil.setStorageVariable(isWechatLogin, forKey: "save_isWechatLogin");
    }
    
    //Login
    static func isLogin() -> Bool {
        if (LotteryUtil.token() != nil) {
            return true;
        } else {
            return false;
        }
    }
    
    //ShouldLogin
    static func shouldLogin() {
        if (LotteryUtil.isLogin() == false) {
            LotteryRoutes.routeLogin();
        }
    }
    
    //ClearLoginSession
    static func clearLoginSession() {
        LotteryUtil.saveToken(token: nil);
        LotteryUtil.saveUser(user: nil);
        //        JPUSHService.setAlias("", callbackSelector: nil, object: nil);
    }
    
    //LotteryHasSuffix
    static func hasSuffix(content: String, suffix: String) -> Bool {
        let content = content.lowercased();
        return content.hasSuffix(suffix)
    }
    
    //OrderListDateArray
    static func orderListDateArray(content: String) -> Array<String> {
        var monthContent = "";
        var dayContent = "";
        for char in content.characters {
            if (monthContent.contains("月") == false) {
                monthContent.append(char);
            } else {
                if (char == "日") {
                    break;
                }
                dayContent.append(char);
            }
        }
        return [monthContent, dayContent];
    }
    //
    
    //WinningNumbers
    static func winningNumbersAttributedString(winningNumbers: String?) -> NSAttributedString {
        let attString = NSMutableAttributedString();
        var color = COLOR_RED;
        if (winningNumbers != nil) {
            for char in winningNumbers!.characters {
                if (char == ":") {
                    color = COLOR_BLUE;
                    attString.append(NSAttributedString(string: " "));
                } else {
                    attString.append(NSAttributedString(string: String(char), attributes: [NSForegroundColorAttributeName:color]));
                }
                
            }
        }
        return attString;
    }
    
}
