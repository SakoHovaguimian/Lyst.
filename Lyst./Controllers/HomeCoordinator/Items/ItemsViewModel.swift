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
    func openLinkAccountVC(list: List)
    func presentAddItemVC(list: List)
    func presentWebView(item: Item)
    func presentAddLystVC(config: DataStateConfig, list: List)
}

class ItemsViewModel {
    
    weak var actionDelegate: ItemVCActionDelegate!
    
    private(set) var list: List!
    private(set) var user: User!
    
    public var buttonState = false
    
    //0 for profile header 1 and 2 for completed and incomplted tasks
    public var numberOfSections: Int {
        return 3
    }
    
    init(list: List) {
        self.list = list
    }
    
    //MARK:- BUTTONS AND ACTIONS
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popItemViewController()
    }
    
    public func handleAddButtonTapped(_ sender: UIButton) {
        self.actionDelegate.presentAddItemVC(list: self.list)
        logSuccess("Add Button Tapped in View Model")
    }
    
    public func handleOptionsButtonTapped(_ sender: UIButton) {
        self.actionDelegate.openLinkAccountVC(list: self.list)
        logSuccess("Options Button Tapped: Loading....")
    }
    
    public func handleLinkButtonTapped(item: Item) {
        self.actionDelegate.presentWebView(item: item)
        print(logSuccess("Link Button Tapped"))
    }
    
    public func handleImageButtonTapped(item: Item) {
        //Do Delegate To Show Image Full Screen or Straight To Detail
        logSuccess("Image Button Tapped for: \(item.name)")
    }
    
    //MARK:- HELPER FUNCTIONS
    
    public func handleSelectedOption(_ option: Option) {
        
        switch option {
            case .uncheck: self.uncheckAllItems()
            case .rename: self.actionDelegate.presentAddLystVC(config: .update, list: self.list)
            case .share: self.actionDelegate.openLinkAccountVC(list: self.list)
            case .members: logSuccess("View more members button tapped")
        }
        
    }
    
    //MARK:- SERVICES
    
    public func fetchList(completion: @escaping () -> ()) {
        
        let uid = self.list.authorUID()
        
        LystService.fetchList(uid: uid, id: self.list.id) { list in
            self.list = list == nil ? self.list : list
            completion()
        }
        
    }
    
    public func updateItem(item: Item, completion: @escaping () -> ()) {
        item.isCompleted.toggle()
        let uid = self.list.authorUID()
        ItemService.updateItem(forList: self.list, item: item, uid: uid) { list in
            completion()
        }
        
    }
    
    public func removeItem(item: Item, completion: @escaping () -> ()) {
        let uid = self.list.authorUID()
        ItemService.updateItem(forList: self.list, item: item, uid: uid, shouldRemove: true) { list in
            completion()
        }
        
    }
    
    public func uncheckAllItems() {
        self.list.items.forEach({ $0.isCompleted = false })
        let uid = self.list.authorUID()
        ItemService.updateAllItemsInList(uid: uid, self.list)
    }
    
    //MARK:- TABLE VIEW LOGIC
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        guard section != 0 else { return 0 }
        return section == 1 ? self.list.incompleteItems.count : self.list.completedItems.count
    }
    
    public func isFirstCell(_ indexPath: IndexPath) -> Bool {
        guard indexPath.section != 0 else { return false }
        return indexPath.row == 0
    }
    
    public func isLastCell(_ indexPath: IndexPath) -> Bool {
        guard indexPath.section != 0 else { return false }
        let itemCount = indexPath.section == 1 ? self.list.incompleteItems.count : self.list.completedItems.count
        return indexPath.row == itemCount - 1
        
    }
    
    public func removeItemAt(indexPath: IndexPath) {
        
        let item: Item?
        
        if indexPath.section == 1 {
            item = self.list.incompleteItems[indexPath.row]
        } else {
            item = self.list.completedItems[indexPath.row]
        }
        
        self.removeItem(item: item!) {
            
        }
        
    }
    
    public func getItemAt(indexPath: IndexPath) -> Item? {
        
        let item: Item?
        
        if indexPath.section == 1 {
            item = self.list.incompleteItems[indexPath.row]
        } else {
            item = self.list.completedItems[indexPath.row]
        }
        
        return item
        
    }
    
    public func updateItemFinishedState(_ item: Item) {
        self.updateItem(item: item) {
        }
    }
    
    public func configureCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> ItemTableViewCell? {
        
        guard indexPath.section != 0 else { return nil }
        
        let sectionItems = indexPath.section == 1 ? self.list.incompleteItems : self.list.completedItems
        let item = sectionItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        
        let isFirstCell = self.isFirstCell(indexPath)
        let isLastCell = self.isLastCell(indexPath)
        
        cell.configureViews(item: item, isFirstCell: isFirstCell, isLastCell: isLastCell)
        return cell
        
    }
    
    public func tableViewSectionHeaderFor(section: Int, tableView: UITableView) -> UITableViewHeaderFooterView? {
        
        if section == 0 {
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as! TableHeaderView
            vw.configure(list: self.list)
            return vw
            
        } else {
            
            
            guard !self.list.items.isEmpty else { return nil }
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CompletionTableHeaderView") as! CompletionTableHeaderView
            vw.configure(text: section == 1 ? "ITEMS" : "COMPLETED")
            return vw
            
        }
        
    }
    
    public func heightForRowAt(indexPath: IndexPath, height: CGFloat) -> CGFloat {
        
        if let item = self.getItemAt(indexPath: indexPath) {
            
            switch item.content {
                case .text, .link: return height / 8.5
                case .photo, .all: return height / 7.0
            }
            
        }
        
        return height / 8.5
        
    }
    
}
