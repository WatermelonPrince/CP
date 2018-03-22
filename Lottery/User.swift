//
//  User.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class User: BaseModel {
    static let MALE = 0;
    static let FEMALE = 1;
    
    var userId: String?;
    var mobile: String?;
    var avatar: String?;
    var name: String?;
    var gender: Int?;

}
