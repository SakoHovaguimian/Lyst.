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
    
    //0 for profile header 1 and 2 for completed and incomplted tasks
    public var numberOfSections: Int {
        return 3
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
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        guard section != 0 else { return 0 }
        return section == 1 ? self.list.incompleteItems.count : self.list.completedItems.count
    }

    public func addItems() {
        let item = Item()
        item.name = "Milk"
        self.list.items.append(item)
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
    
    public func updateItemFinishedState(_ item: Item) {
        item.isCompleted.toggle()
    }
    
    public func configureCellForRowAt(indexPath: IndexPath, tableView: UITableView) -> ItemTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        guard indexPath.section != 0 else { return cell }
        let sectionItems = indexPath.section == 1 ? self.list.incompleteItems : self.list.completedItems
        let item = sectionItems[indexPath.row]
        let isFirstCell = self.isFirstCell(indexPath)
        let isLastCell = self.isLastCell(indexPath)
        cell.configureViews(item: item, isFirstCell: isFirstCell, isLastCell: isLastCell)
        return cell
        
    }
    
    public func tableViewSectionHeaderFor(section: Int, tableView: UITableView) -> UITableViewHeaderFooterView {
        
        if section == 0 {
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as! TableHeaderView
            vw.configure(list: self.list)
            return vw
            
        } else {
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CompletionTableHeaderView") as! CompletionTableHeaderView
            vw.configure(text: section == 1 ? "TO DO" : "COMPLETED")
            return vw
            
        }
        
    }
    
}
