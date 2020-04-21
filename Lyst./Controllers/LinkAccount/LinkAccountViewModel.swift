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
    
    init(user: User) {
        self.user = user
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popLinkAccountViewController()
    }
    
}
