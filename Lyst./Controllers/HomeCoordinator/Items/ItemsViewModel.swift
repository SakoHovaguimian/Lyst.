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
    func removeListForUser(list: List)
}

class ItemsViewModel {
    
    weak var actionDelegate: ItemVCActionDelegate!
    
    private(set) var list: List!
    private(set) var user: User!
    
    public var buttonState = false
    
    init(user: User, list: List) {
        self.list = list
        self.user = user
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
            case .delete: self.removeOrDeleteList()
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
    
    public func fetchItems(completion: @escaping () -> ()) {
        
        let uid = self.list.authorUID()
    
        ItemService.fetchItems(forList: self.list, uid: uid) { items in
            
            if let items = items {
                self.list.items = items
            }
            
            completion()
            
        }
        
    }
    
    public func uncheckAllItems() {
        self.list.items.forEach({ $0.isCompleted = false })
        let uid = self.list.authorUID()
        ItemService.updateAllItemsInList(uid: uid, self.list)
    }
    
    public func handleRemoveList() {
        
        let subscription = user.subscriptions?.filter({ $0.listId == self.list.id }).first
        
        if let subscription = subscription {
            
            SubscriptionService.removeSubscription(subscription: subscription, email: self.user
                .email) { _ in
                    
                    self.actionDelegate.removeListForUser(list: self.list)
                    
                    logDebugMessage("\(self.user.name) has successfully removed the list: ] \(self.list.name)")
                    
            }
        }
        
    }
    
    public func handleDeleteList() {
        
        SubscriptionService.deleteAllSubscriptions(for: self.list) {

            self.actionDelegate.removeListForUser(list: self.list)
            LystService.deleteList(uid: self.user.userId ?? "", list: self.list)
            
        }
        
        
        logDebugMessage("This is the author, remove from everybody")
    }
    
    public func removeOrDeleteList() {
        
        if self.list.isAuthor() {
            self.handleDeleteList()
        } else {
            self.handleRemoveList()
        }
        
    }
    
    //MARK:- TABLE VIEW LOGIC
    
    //0 for profile header 1 and 2 for completed and incomplted tasks
    public var numberOfSections: Int {
        return 3
    }
    
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
    
    public func configureBasicContentCell(indexPath: IndexPath, tableView: UITableView) -> ItemTableViewCell? {
        
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
    
    public func heightForRowAt(height: CGFloat) -> CGFloat {
        return height / 8.5
    }
    
}
