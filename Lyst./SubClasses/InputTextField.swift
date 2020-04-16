//
//  InputTextField.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class InputTextField: UITextField {

    init(placeholder: String, secureEntry: Bool) {
        super.init(frame: .zero)
        self.configureTextField(placeholder: placeholder, isSecure: secureEntry)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField(placeholder: String, isSecure: Bool) {
    
        self.autocapitalizationType = .none
        self.borderStyle = .roundedRect
        self.backgroundColor = .lighterGray
        self.textColor = .charcoalBlack
        self.isSecureTextEntry = isSecure
        self.font = UIFont(name: avenirNextBold, size: 15.0)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        self.leftViewMode = .always
        self.addShadow(shadow: .black,
                     opacity: 0.5, offSet: .zero, raidus: 1.0)
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }

}
