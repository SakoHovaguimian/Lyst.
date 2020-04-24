//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol AddItemVCActionDelegate: class {
    func popAddItemViewController()
    func updateListItems(_ list: List)
}

class AddItemViewModel {
    
    private(set) var list: List!
    private(set) var item = Item()
    
    public var categorySelectedRow = 0
    
    weak var actionDelegate: AddItemVCActionDelegate!
    
    init(list: List) {
        self.list = list
    }
    
    private func handlePopViewController() {
        self.actionDelegate.popAddItemViewController()
    }
    
    public func handleCloseButtonTapped(_ sender: UIButton) {
        self.handlePopViewController()
    }
    
    public func handleCreateItemButtonTapped(_ sender: UIButton) {
        self.item.id = "\(self.list.items.count + 1)"
        self.list.items.append(self.item)
        self.actionDelegate.updateListItems(self.list)
    }
    
    public func handleOutsideCardViewTapped() {
        self.handlePopViewController()
    }

}
