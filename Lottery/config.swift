//
//  config.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import Foundation
import UIKit

let KEY_WINDOW = UIApplication.shared.keyWindow!;
let SCREEN_WIDTH = UIScreen.main.bounds.size.width;
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height;
let K_FONT_SIZE:CGFloat = (SCREEN_WIDTH <= 320) ? 13 : 14;
let BANNER_HEIGHT = SCREEN_WIDTH/1080*400;
let BALL_WIDTH = SCREEN_WIDTH/(7+8*0.3);

let COLOR_WHITE = UIColor.white;
let COLOR_RED = UIColor(colorLiteralRed: 233/255, green: 43/255, blue: 64/255, alpha: 1);
let COLOR_RED_NAV = UIColor(colorLiteralRed: 227.5/255, green: -15/255, blue: 17.1/255, alpha: 1);
let COLOR_BLUE = UIColor(colorLiteralRed: 55/255, green: 120/255, blue: 233/255, alpha: 1);
let COLOR_BLACK = UIColor(colorLiteralRed: 23/255, green: 23/255, blue: 25/255, alpha: 1);
let COLOR_YELLOW = UIColor(colorLiteralRed: 255/255, green: 222/255, blue: 37/255, alpha: 1);
let COLOR_LIGHT_YELLOW = UIColor(red: 252/255, green: 251/255, blue: 212/255, alpha: 1);
let COLOR_BROWN = UIColor.brown;
let COLOR_GROUND = UIColor(colorLiteralRed: 248/255, green: 247/255, blue: 239/255, alpha: 1);
let COLOR_FONT_HEAD = UIColor(colorLiteralRed: 46/255, green: 141/255, blue: 181/255, alpha: 1);
let COLOR_FONT_TEXT = UIColor.black;
let COLOR_FONT_SECONDARY = UIColor(colorLiteralRed: 101/255, green: 104/255, blue: 110/255, alpha: 1);
let COLOR_FONT_MONEY = UIColor(colorLiteralRed: 246/255, green: 149/255, blue: 35/255, alpha: 1);
let COLOR_BORDER = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1);
let COLOR_TIP = UIColor(colorLiteralRed: 246/255, green: 112/255, blue: 114/255, alpha: 1);
let COLOR_MASK = UIColor(white: 0.0, alpha: 0.3);
let COLOR_WECHAT = UIColor(colorLiteralRed: 60/255, green: 176/255, blue: 52/255, alpha: 1);

let DIMEN_BORDER:CGFloat = 0.5;

let DOTS_SYMBOL:String = "•••";

let WECHAT_ID = "wx2204a1a488ff5325";
let GROWINGIO_ID = "bd46af1b14c2b9d4";
let BUGLY_ID = "20b7b3dbc6";
//getui测试
//let kGtAppId:String = "WqFbMKc7Kk5qChEJamyR56"
//let kGtAppKey:String = "84sRp1IZJhAlq44RjwG0H2"
//let kGtAppSecret:String = "zDTrIZf0or7UTtoVcL6zW2"
//getui正式
let kGtAppId:String = "oOyM8Ziljn5pX7RFBuIpdA"
let kGtAppKey:String = "9Kiud3d6NE8FfBC5rp2Uh1"
let kGtAppSecret:String = "VCZ0rxYyAz9ruwc4bywn6A"
//友盟key
let uMengKey:String = "5975700a3eae253456001776"



struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
