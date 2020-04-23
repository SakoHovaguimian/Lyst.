//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol AddListVCActionDelegate: class {
    func popAddListViewController()
    func addCreatedList(_ list: List)
}

class AddListViewModel {
    
    private(set) var list = List(name: "", category: .shopping)
    
    public var categorySelectedRow = 0
    
    weak var actionDelegate: AddListVCActionDelegate!
    
    private func handlePopViewController() {
        self.actionDelegate.popAddListViewController()
    }
    
    public func handleCloseButtonTapped(_ sender: UIButton) {
        self.handlePopViewController()
    }
    
    public func handleCreateListButtonTapped(_ sender: UIButton) {
        self.actionDelegate.addCreatedList(self.list)
    }
    
    public func handleOutsideCardViewTapped() {
        self.handlePopViewController()
    }

}
