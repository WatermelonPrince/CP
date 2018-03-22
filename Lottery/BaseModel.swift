 //
//  BaseModel.swift
//  Lottery
//
//  Created by DTY on 2017/4/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BaseModel: HandyJSON {

    required init() {
        
    }
    
    static func jsonToModel(json: JSON) -> BaseModel?{
        let model = BaseModel.deserialize(from: json.rawString());
        return model;
    }
}
