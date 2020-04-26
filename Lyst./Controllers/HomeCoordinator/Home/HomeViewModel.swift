//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo
import Firebase
import FirebaseAuth

protocol HomeVCActionsDelegate: class {
    func presentLoginVC(animated: Bool)
    func presentAddListVC()
    func pushItemVC(list: List)
//    func pushLinkAccountVC(user: User)
}

class HomeViewModel {
    
    weak var actionDelegate: HomeVCActionsDelegate!
    
    private(set) var user: User? = nil
     
    public var lists: [List] {
        return self.user?.lists ?? []
    }
    
    public var sharedLists: [List] {
        return self.user?.sharedLists ?? []
    }
    
    public var shouldHideTableView: Bool = false
    
    public var isUserAvailable: Bool {
        return self.user != nil
    }
    
    public func updateUser(withUser user: User) {
        self.user = user
    }
    
    public func addList(_ list: List) {
        self.user?.lists.append(list)
    }
    
    public func handleAddButtonTapped(_ sender: UIButton) {
        self.actionDelegate.presentAddListVC()
        logSuccess("PRESENTING ADD LIST VC")
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
//        self.actionDelegate.pushLinkAccountVC(user: self.user!)
        logSuccess("LINKING ACCOUNTS...")
    }
    
    public func handlePushItemsViewController(list: List) {
        self.actionDelegate.pushItemVC(list: list)
    }
    
    public func presentLoginController()  {
        self.actionDelegate.presentLoginVC(animated: false)
        logDebugMessage("Load Login Controller")
    }
    
    //MARK:- Services
    
    public func checkIfUserIsLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    public func fetchUser(completion: @escaping() -> ()) {
        
        guard let user = Auth.auth().currentUser else { completion(); return }
        
        UserService.fetchUser(uid: user.uid) { (user) in
            
            self.user = user
            completion()
            
        }
        
    }
    
    //MARK:- Table View Data
    
    //0 for profile header 1 and 2 for completed and incomplted tasks
    public var numberOfSections: Int {
        return 3
    }
    
    public func numberOfItemsInSection(_ section: Int) -> Int {
        guard section != 0 else { return 0 }
        return section == 1 ? self.lists.count : self.sharedLists.count
    }
    
    public func listFor(indexPath: IndexPath) -> List {
        
        let list = indexPath.section == 1 ? self.lists[indexPath.row] :self.sharedLists[indexPath.row]
        return list
        
    }
    
    public func tableViewSectionHeaderFor(section: Int, tableView: UITableView) -> UITableViewHeaderFooterView? {
        
        if section == 0 {
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as! TableHeaderView
            vw.configure(user: self.user!)
            return vw
            
        } else {
    
            if section == 2 && self.sharedLists.isEmpty {
                return nil
            }
            
            let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CompletionTableHeaderView") as! CompletionTableHeaderView
            let title = section == 1 ? "My Lysts" : "Shared Lysts"
            vw.configure(text: title)
            return vw
            
        }
        
    }
    
}
