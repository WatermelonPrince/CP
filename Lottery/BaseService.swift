//
//  BaseService.swift
//  Lottery
//
//  Created by DTY on 2017/4/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

@objc protocol ServiceDelegate: class {
    func onCompleteSuccess(service: BaseService);
    @objc optional func onCompleteFail(service: BaseService);
}

class BaseService: CommonHttpRequest {
    weak var delegate : ServiceDelegate?;
    let pageSize = 20;
    
    override init() {
        super.init();
    }
    
    init(delegate: ServiceDelegate) {
        self.delegate = delegate;
    }

    func onCompleteSuccess() {
        self.delegate?.onCompleteSuccess(service: self);
    }
    
    override func onCompleteFail() {
        if (self.delegate?.onCompleteFail?(service: self) != nil) {
            self.delegate?.onCompleteFail!(service: self);
        }
    }
    
}
