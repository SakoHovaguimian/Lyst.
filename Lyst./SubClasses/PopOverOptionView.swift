//
//  PopOverOptionView.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/27/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class PopOverOptionView: UIView {
    
    static let identifier = "PopOverOptionView"
    
    private var option: Option!

    public lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    init(option: Option, tag: Int) {
        super.init(frame: .zero)
        self.option = option
        
        self.configureViews(tag: tag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(tag: Int) {
        
        self.backgroundColor = .white
        self.configureButton(tag: tag)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lighterGray
        
        self.addSubview(seperatorView)
        
        seperatorView.anchor(left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             height: 1)
        
    }
    
    private func configureButton(tag: Int) {
        
        self.addSubview(self.button)
        
        self.button.addConstraintsToFillView(self)
        
        self.button.tag = tag
        self.button.setTitle(self.option.name, for: .normal)
        self.button.titleLabel?.font = UIFont(name: avenirNextBold, size: 15.0)
        self.button.setTitleColor(.charcoalBlack, for: .normal)
        self.button.backgroundColor = .white
        
    }
    
}
