//
//  OrderBottomMultipleBarView.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderBottomMultipleBarView: UIView {
    var mainView: OrderBottomMultipleBarMainView!;
    var termView: OrderBottomMultipleBarTermView!;
    var termStopView: OrderBottomMultipleBarTermStopView!;
    var multipleView: OrderBottomMultipleBarMultipleView!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandle(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandle(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.mainView);
        self.insertSubview(self.termStopView, belowSubview: self.mainView);
        self.addSubview(self.termView);
        self.addSubview(self.multipleView);
        
        self.mainView.termTextField.addTarget(self, action: #selector(termTextFieldDidChange), for: .editingChanged);
        self.mainView.multipleTextField.addTarget(self, action: #selector(multipleTextFieldDidChange), for: .editingChanged);
        self.termStopView.isHidden = true;
        self.termView.isHidden = true;
        self.multipleView.isHidden = true;
        
        for button in self.termView.subviews {
            if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                let button = button as! OrderBottomMultipleBarBaseButton;
                button.addTarget(self, action: #selector(termButtonAction(_:)), for: .touchUpInside)
            }
        }
        
        for button in self.multipleView.subviews {
            if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                let button = button as! OrderBottomMultipleBarBaseButton;
                button.addTarget(self, action: #selector(multipleButtonAction(_:)), for: .touchUpInside)
            }
        }
        
    }
    
    func termButtonAction(_ button: OrderBottomMultipleBarBaseButton) {
        for button in self.termView.subviews {
            if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                (button as! OrderBottomMultipleBarBaseButton).isSelected = false;
            }
        }
        button.isSelected = true;
        self.mainView.termTextField.text = String(button.textInt);
        self.termTextFieldDidChange();
    }
    
    func multipleButtonAction(_ button: OrderBottomMultipleBarBaseButton) {
        for button in self.multipleView.subviews {
            if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                (button as! OrderBottomMultipleBarBaseButton).isSelected = false;
            }
        }
        button.isSelected = true;
        self.mainView.multipleTextField.text = String(button.textInt);
        self.multipleTextFieldDidChange();
    }
    
    func termTextFieldDidChange() {
        let termText = self.mainView.termTextField.text;
        if (termText != nil && termText != "" && Int(termText!)! > 1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.mainView.frame.origin.y = 0;
            })
            self.termStopView.isHidden = false;
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.mainView.frame.origin.y = 40;
            })
            self.termStopView.isHidden = true;
        }
        
        if (termText != nil && termText != "") {
            let termInt = Int(termText!)!;
            for button in self.termView.subviews {
                if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                    let button = button as! OrderBottomMultipleBarBaseButton;
                    if (termInt == button.textInt) {
                        button.isSelected = true;
                    } else {
                        button.isSelected = false;
                    }
                }
            }
            
        }
        
    }
    
    func multipleTextFieldDidChange() {
        let multipleText = self.mainView.multipleTextField.text;
        if (multipleText != nil && multipleText != "") {
            let multipleInt = Int(multipleText!)!;
            for button in self.multipleView.subviews {
                if (button.isKind(of: OrderBottomMultipleBarBaseButton.classForCoder())) {
                    let button = button as! OrderBottomMultipleBarBaseButton;
                    if (multipleInt == button.textInt) {
                        button.isSelected = true;
                    } else {
                        button.isSelected = false;
                    }
                }
            }
            
        }
    }
    
    func keyboardHandle(_ notification: Notification){
        if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
            if (self.mainView.termTextField.isFirstResponder) {
                if (self.termStopView.isHidden) {
                    UIView.animate(withDuration: 0.3, animations: {
                       self.mainView.frame.origin.y = 40;
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.mainView.frame.origin.y = 0;
                    })
                }
                self.multipleView.isHidden = true;
                
            } else if (self.mainView.multipleTextField.isFirstResponder) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.mainView.frame.origin.y = 40;
                })
                self.multipleView.isHidden = false;
            }
        }
    }

}
