//
//  UIViewController+ext.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func checkIfTextFieldsAreEmpty(_ textFields: [UITextField]) -> Bool {
        
        for textField in textFields {
            if let text = textField.text {
                if text.count < 2 { return false }
            } else {
                return false
            }
        }
        
        return true
        
    }
    
    public func updateButtonState(_ textField: [UITextField], _ button: UIButton) {
        
        let isEnabled = self.checkIfTextFieldsAreEmpty(textField)
        
        button.isEnabled = isEnabled
        button.alpha = isEnabled ? 1.0 : 0.4
        
    }
    
}
