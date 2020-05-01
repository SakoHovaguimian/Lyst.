//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

enum DataStateConfig: String {
    
    case create
    case update
    
    var name: String {
        
        switch self {
            case .create: return "Create Lyst"
            case .update: return "Update Lyst"
        }
        
    }
    
}

protocol AddListVCActionDelegate: class {
    func popAddListViewController()
    func addCreatedList(_ list: List)
}

class AddListViewModel {
    
    //MARK:- Properties
    
    private(set) var list = List(name: "", category: .groceries)
    private(set) var config: DataStateConfig!
    
    public var categorySelectedRow = 0
    
    weak var actionDelegate: AddListVCActionDelegate!
    
    public var submitButtonText: String {
        return self.config.name
    }
    
    init(config: DataStateConfig, list: List? = nil) {
        
        self.config = config
        
        if let list = list {
            self.list = list
        }
        
    }
    
    //MARK:- Button Actions
    
    private func handlePopViewController() {
        self.actionDelegate.popAddListViewController()
    }
    
    public func handleCloseButtonTapped(_ sender: UIButton) {
        self.handlePopViewController()
    }
    
    public func handleSubmitButtonTapped(_ sender: UIButton) {
        self.handleSubmitButtonHelper()
    }
    
    public func handleOutsideCardViewTapped() {
        self.handlePopViewController()
    }
    
    //MARK:- Helper Functions
    
    public func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        self.list.name = text
        
    }
    
    public func animateAlphaFor(_ view: UIView, value: CGFloat, instant: Bool = false) {
        
        guard instant == false else {
            view.alpha = 0.0
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            view.alpha = value
        })
        
    }
    
    private func handleSubmitButtonHelper() {
        
        if self.config == .create {
            
            self.createList { _ in
                
                self.actionDelegate.popAddListViewController()
                
            }
            
        } else {
            
            self.updateList { _ in
                
                self.actionDelegate.popAddListViewController()
                
            }
            
        }
        
    }
    
    //MARK:- Services
    
    private func createList(completion: @escaping (String) -> ()) {
        
        LystService.createList(list: self.list) { _ in
            completion("")
        }
        
    }
    
    private func updateList(completion: @escaping (String) -> ()) {
        
        let uid = self.list.authorUID()
        
        LystService.updateList(uid: uid, self.list)
        completion("")
        
    }
    
    
}
