//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol LinkVCActionDelegate: class {
    func popLinkAccountViewController()
}

class LinkAccountViewModel {
    
    weak var actionDelegate: LinkVCActionDelegate!
    
    private(set) var user: User!
    
    public var pin: String {
        return "\(user.pin)"
    }
    
    public var enteredPin: String = "0000"
    public var enteredEmail: String = ""
    
    
    init(user: User) {
        self.user = user
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popLinkAccountViewController()
    }
    
    public func createPin(textFields: [UITextField]) {
        let pin = textFields.map({($0.text ?? "0")}).joined(separator: "")
        self.enteredPin = pin
    }
    
    public func handlePinTextFieldEntries(_ textField: UITextField, string: String) -> Bool {
        
        if textField.text!.count < 1  && string.count > 0 {
            let nextTag = textField.tag + 1

            let nextResponder = textField.superview?.viewWithTag(nextTag)
            
            textField.text = string
            nextResponder?.becomeFirstResponder()
            
            if (nextResponder == nil) {
                textField.resignFirstResponder()
            }
            
            return false
            
        } else if textField.text?.count == 1 && string.count > 0 {
            
            let nextTag = textField.tag + 1

            if let nextResponder = textField.superview?.viewWithTag(nextTag) as? PinTextField {
                nextResponder.text = string
                
                nextResponder.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }

            return false
            
        } else if string.count == 0 {

            let previousTag = textField.tag - 1

            let previousResponder = textField.superview?.viewWithTag(previousTag)
            
            textField.text = ""
            
            textField.resignFirstResponder()
            
            previousResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        textField.resignFirstResponder()
        return false

    }
    
}
