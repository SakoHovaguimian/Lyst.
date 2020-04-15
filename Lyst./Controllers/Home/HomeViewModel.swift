//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol PresentLoginViewControllerDelegate: class {
    func presentLoginVC()
}

class HomeViewModel {
    
    weak var loginDelegate: PresentLoginViewControllerDelegate!
    
    private(set) var user: User? = nil
    
    public var shouldHideTableView: Bool = false
    
    public func updateUser(withUser user: User) {
        self.user = user
    }
    
    public func handleAddButtonTapped(_ sender: UIButton) {
        //Delegate to present modally Coordinator
    }
    
    public func handleListsButtonTapped(_ sender: UIButton) {
        sender.tintColor = .charcoalBlack
        self.shouldHideTableView = false
    }
    
    public func handleSettingsButtonTapped(_ sender: UIButton) {
        self.shouldHideTableView = true
        sender.tintColor = .charcoalBlack
    }
    
    public func presentLoginController() -> Bool {
        
        guard self.user == nil else { return false }
        
        logDebugMessage("Load Login Controller")
        self.loginDelegate.presentLoginVC()
        return true
        
    }
    
}
