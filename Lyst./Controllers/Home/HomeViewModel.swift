//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol HomeVCActionsDelegate: class {
    func presentLoginVC(animated: Bool)
    func pushItemVC(list: List)
}

class HomeViewModel {
    
    weak var actionDelegate: HomeVCActionsDelegate!
    
    private(set) var user: User? = nil
     
    private(set) var lists: [List] = List.generateList()
    
    public var numberOfLists: Int {
        return self.lists.count
    }
    
    public var shouldHideTableView: Bool = false
    
    public var isUserAvailable: Bool {
        return self.user != nil
    }
    
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
    
    public func handleLogOutButtonTapped(_ sender: UIButton) {
        self.actionDelegate.presentLoginVC(animated: true)
        logSuccess("LOGGING OUT")
    }
    
    public func handleSettingButtonTapped(_ sender: UIButton) {
        logSuccess("SETTING BUTTON TAPPED")
    }
    
    public func handleLinkAccountButtonTapped(_ sender: UIButton) {
        logSuccess("LINKING ACCOUNTS...")
    }
    
    public func handlePushItemsViewController(list: List) {
        self.actionDelegate.pushItemVC(list: list)
    }
    
    public func presentLoginController()  {
        logDebugMessage("Load Login Controller")
        self.actionDelegate.presentLoginVC(animated: false)
    }
    
}
