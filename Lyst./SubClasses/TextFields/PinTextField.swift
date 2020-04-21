//
//  PinTextField.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/21/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class PinTextField: UITextField {
    
    init(tag: Int) {
        super.init(frame: .zero)
        self.configureTextField(tag: tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField(tag: Int) {
        
        self.keyboardType = .numberPad
        self.borderStyle = .roundedRect
        self.tag = tag
        self.backgroundColor = .lighterGray
        self.textColor = .charcoalBlack
        self.font = UIFont(name: avenirNextBold, size: 30.0)
        self.textAlignment = .center
        self.addShadow(shadow: .black,
                       opacity: 0.7, offSet: .zero, raidus: 1.0)
        self.attributedPlaceholder = NSAttributedString(string: "0",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
    }
    
}
