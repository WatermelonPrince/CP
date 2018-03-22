//
//  CommonUtil.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import AudioToolbox;
import StoreKit

class CommonUtil: NSObject {

    static func creatImageWithColor(color:UIColor)-> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func timestampToString(_ time:Int64?, format:String?) -> String? {
        if (time == nil || format == nil) {
            return nil;
        }
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = format;
        
        let date = Date(timeIntervalSince1970: TimeInterval(time! / 1000));
        return dateFormatter.string(from: date);
    }
    
    static func dateFromString(_ toMonth: Bool, content: String) -> Date {
        let dateFormatter = DateFormatter();
        if toMonth {
            dateFormatter.dateFormat = "yyyy-MM";
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd";
            
        }
        let date = dateFormatter.date(from: content);
        if date != nil {
            return date!;
        } else {
            return Date();
        }
    }
    
    static func stringFromDate(_ toMonth: Bool, date: Date) -> String {
        let dateFormatter = DateFormatter();
        if toMonth {
            dateFormatter.dateFormat = "yyyy-MM";
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd";
        }
        let content = dateFormatter.string(from: date);
        return content;
    }
    
    static func mSStringFromTimeInterval(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval);
        let timeFormatter = DateFormatter();
        var timeStr = ""
        timeFormatter.dateFormat = "mm:ss"
        if (timeInterval > 59+59*60) {
            let hourStr = Int(timeInterval/(60 * 60))
            timeStr = "\(hourStr):\(timeFormatter.string(from: date))"
        } else {
            timeStr = timeFormatter.string(from: date);

        }
        
        return timeStr;
    }
    
    static func getURL(_ url: String?) -> URL? {
        var url = url;
        
        if url == nil {
            return nil;
        }
        
        url = url!.replacingOccurrences(of: "|", with: "%7c");
        return URL(string: url!);
    }
    
    static func toChineseNumber(number: Int) -> String {
        if (number > 10) {
            return "";
        }
        
        let chineseArray = ["零","一","二","三","四","五","六","七","八","九","十"];
        
        return chineseArray[number];
    }
    
    static func toBallNumberString(i:Int)-> String{
        if (i < 10) {
            return "0\(i)"
        } else {
            return "\(i)"
        }
    }
    
    static func toBallAttributedString(string: String)-> NSMutableAttributedString {
        var string = string;
        var hyphenLocation = 0;
        for char in string.characters.enumerated() {
            if (char.element == ":") {
                hyphenLocation = char.offset;
                string = string.replacingOccurrences(of: ":", with: " ");
                break;
            }
        }
        
        if (hyphenLocation == 0) {
            hyphenLocation = string.characters.count;
        }
        let attString = NSMutableAttributedString(string: string);
        attString.addAttribute(NSForegroundColorAttributeName, value: COLOR_RED, range: NSMakeRange(0,hyphenLocation));
        attString.addAttribute(NSForegroundColorAttributeName, value: COLOR_BLUE, range: NSMakeRange(hyphenLocation,string.characters.count-hyphenLocation));
        return attString;
    }
    
    static func heightOfBallBoard(number:Int)-> CGFloat{
        
        let height = CGFloat(5*CGFloat((number-1)/7+2)+BALL_WIDTH*CGFloat((number-1)/7+1));
        return height;
    }
    
    static func calculateCombination(n: Int, m: Int) -> Int {
        if (n < m) {
            return 0;
        }
        var result = 1;
        for i in 1..<n+1-m {
            result = (i+m)*result/i;
        }
        return result;
    }
    
    static func autoLabelHeight(text: String, labelWidth: CGFloat, attributes:[String : Any]?) -> CGFloat {
        var rect = CGRect();
        let size = CGSize(width: labelWidth, height: 0);
        rect = text.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil);
        return rect.size.height;
    }
    
    static func autoLabelHeight(text: String, labelWidth: CGFloat) -> CGFloat {
        return CommonUtil.autoLabelHeight(text: text, labelWidth: labelWidth, attributes: nil);
    }
    
    static func colorWithAlpha(color: UIColor, alpha: CGFloat) -> UIColor {
        let cgColor = color.cgColor;
        if (cgColor.components == nil) {
            return COLOR_WHITE;
        }
        let r = cgColor.components![0];
        let g = cgColor.components![1];
        let b = cgColor.components![2];
        return UIColor(colorLiteralRed: Float(r), green: Float(g), blue: Float(b), alpha: Float(alpha));
    }
    
    static func randomIntArray(total: Int, count: Int) -> [Int] {
        var startArray = Array(1...total);
        var resultArray = Array(repeating: 0, count: count)
        for i in 0..<count {
            let currentCount = UInt32(startArray.count - i)
            let index = Int(arc4random_uniform(currentCount))
            resultArray[i] = startArray[index]
            startArray[index] = startArray[Int(currentCount) - 1]
        }
        
        resultArray.sort{$0 < $1};
        return resultArray;
    }
    
    static func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin];
        let attributes = [NSFontAttributeName: font];
        let boundingRect = text.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: options, attributes: attributes, context: nil);
        return boundingRect.height;
    }
    
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    static func hasMutualInt(intArrayList: [Array<Int>]) -> Bool {
        var sumArray = Array<Int>();
        for intArray in intArrayList {
            for int in intArray {
                if (sumArray.contains(int)) {
                    return true;
                }
            }
            sumArray = sumArray + intArray;
        }
        return false;
    }
    
    static func subStringFromChar(string: String, character: Character) -> String{
        var content = string;
        for char in content.characters.enumerated() {
            if (char.element == character) {
                let index = content.index(content.startIndex, offsetBy: char.offset);
                content = content.substring(to: index);
                break;
            }
        }
        return content;
    }
    
    static func convertString(string: String) -> String {
        let data = string.data(using: String.Encoding.ascii, allowLossyConversion: true)
        return NSString(data: data!, encoding: String.Encoding.ascii.rawValue)! as String
    }
    
    static func formatDoubleString(double: Double) -> String {
        return String(format: "%.2f", double);
    }
    
    static func formatConditionRedPacketString(double: Double) -> String {
        let newDouble = Double(Int(double));
        let doubleString = CommonUtil.formatDoubleString(double: double);
        let newDoubleString = CommonUtil.formatDoubleString(double: newDouble);
        if (doubleString != newDoubleString) {//带小数点
            return doubleString
        } else { //不带小数点
            return String(Int(double));
        }
    }
    
    static func findViewController(view: UIView) -> UIViewController {
        var next: UIView? = view;
        while (next != nil) {
            let nextResponder = next?.next;
            if (nextResponder?.isKind(of: UIViewController.classForCoder()) == true) {
                return nextResponder as! UIViewController
            }
            next = next?.superview;
        }
        return UIViewController();
    }
    
    //存取
    static func getStorageVariable(forKey: String) -> Any? {
        let userDefaults = UserDefaults.standard
        let object = userDefaults.object(forKey: forKey);
        return object;
    }
    
    static func setStorageVariable(_ value: Any?, forKey: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: forKey);
        userDefaults.synchronize();
    }
    
    static func removeUserDefaults(forKey: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: forKey);
    }
    
    
    static func currentProductVersion() -> String {
        var version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String;
        if (version == nil) {
            version = "";
        }
        return version!;
    }
    
    //显示评价
    static func showStoreReviewController() {
        var openTimes = CommonUtil.getStorageVariable(forKey: "save_openAppTimes") as? Int;
        if (openTimes == nil) {
            openTimes = 0;
        }
        
        if (openTimes == 30) {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview();
            } else {
                // Fallback on earlier versions
            };
        }
        
        CommonUtil.setStorageVariable(openTimes! + 1, forKey: "save_openAppTimes");
    }
    
}
