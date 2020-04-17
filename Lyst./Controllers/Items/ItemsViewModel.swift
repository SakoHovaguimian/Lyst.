//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol ItemVCActionDelegate: class {
    func popItemViewController()
}

class ItemsViewModel {
    
    weak var actionDelegate: ItemVCActionDelegate!
    
    private(set) var list: String!
    
    init(list: String) {
        self.list = list
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popItemViewController()
    }
    
    public func handleAddButtonTapped(_ sender: UIButton) {
        logSuccess("Add Button Tapped in View Model")
    }
    
}
