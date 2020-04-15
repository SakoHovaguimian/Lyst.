//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class HomeViewModel {
    
    private(set) var name: String = "Sako Hovaguimian"
    
    public var shouldHideTableView: Bool = false
    
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
    
}
