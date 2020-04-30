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
    
    public var selectedImage: UIImage?
    
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
        //        self.item.id = "\(self.list.items.count + 1)"
        //        self.list.items.append(self.item)
        self.createItem { _ in
            self.actionDelegate.updateListItems(self.list)
        }
    }
    
    public func handleOutsideCardViewTapped() {
        self.handlePopViewController()
    }
    
    public func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        switch textField.tag {
            
        case 0: self.item.name = text
        case 1: self.item.link = text
        default: logError("Something went wrong")
            
        }
        
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
    
    public func createDescLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 14.0)
        return label
    }
    
    public func createInputTextField(placeholder: String, tag: Int, vc: AddItemViewController) -> InputTextField {
        let textField = InputTextField(placeholder: placeholder,
                                       secureEntry: false,
                                       tag: tag)
        textField.delegate = vc
        textField.font = UIFont(name: avenirNextBold, size: 20.0)
        return textField
    }
    
    //MARK:- Services
    
    private func createItem(completion: @escaping (String) -> ()) {
        
        let uid = self.list.authorUID()
        
        ItemService.createItem(forList: self.list, item: self.item, uid: uid) { item in
            
            if let image = self.selectedImage, let item = item {
                
                ItemService.saveImage(item: item, image: image) { url in
                    
                    item.imageURL = url
                    
                    ItemService.updateItem(forList: self.list, item: item, uid: uid) { _ in
                        
                        completion("")
                        
                    }
                    
                }
                
            } else {
                
                completion("")
                
            }
            
        }
        
    }
    
}
