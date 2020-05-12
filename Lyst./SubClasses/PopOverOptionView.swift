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
    
    init(option: Option, isAuthor: Bool) {
        super.init(frame: .zero)
        self.option = option
        
        self.configureViews(isAuthor: isAuthor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(isAuthor: Bool) {
        
        self.backgroundColor = .white
        self.configureButton(isAuthor: isAuthor)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .lighterGray
        
        self.addSubview(seperatorView)
        
        seperatorView.anchor(left: self.leftAnchor,
                             bottom: self.bottomAnchor,
                             right: self.rightAnchor,
                             height: 1)
        
    }
    
    private func configureButton(isAuthor: Bool) {
        
        self.addSubview(self.button)
        
        self.button.addConstraintsToFillView(self)
        
        self.button.tag = option.rawValue
        
        var isNotAuthorText: String?
        
        if option == .delete && isAuthor == false {
            isNotAuthorText = "Remove Lyst"
        }
        
        self.button.setTitle(isNotAuthorText ?? self.option.name, for: .normal)
        self.button.titleLabel?.font = UIFont(name: avenirNextBold, size: 15.0)
        
        let color: UIColor = option == .delete ? .red : UIColor.charcoalBlack!
        
        self.button.setTitleColor(color, for: .normal)
        self.button.backgroundColor = .white
        
    }
    
}
