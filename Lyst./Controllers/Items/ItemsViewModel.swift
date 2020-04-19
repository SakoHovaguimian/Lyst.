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
    
    private(set) var list: List!
    
    public var items: [Item] {
        return self.list.items
    }
    
    public var numberOfItems: Int {
        return self.items.count
    }
    
    init(list: List) {
        self.list = list
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popItemViewController()
    }
    
    public func handleAddButtonTapped(_ sender: UIButton) {
        self.addItems()
        logSuccess("Add Button Tapped in View Model")
    }
    
    public func handleOptionsButtonTapped(_ sender: UIButton) {
        logSuccess("Options Button Tapped: Loading....")
    }
    
    public func addItems() {
        let item = Item()
        item.name = "Milk"
        self.list.items.append(item)
    }
    
}
