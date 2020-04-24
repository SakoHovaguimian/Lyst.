//
//  ItemViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol LinkVCActionDelegate: class {
    func popLinkAccountViewController()
}

class LinkAccountViewModel {
    
    weak var actionDelegate: LinkVCActionDelegate!
    
    private(set) var user: User!
    private(set) var list: List!
    
    private(set) var recentlyShared = [
        "Sako Hovaguimian",
        "Chelsea Eichler",
        "KC Gunderson",
        "Steven Xenos Bibona",
        "Mithc Treece",
        "Libby Bibona",
        "Christopher Carl Bibona"
    ].shuffled()
    
    public var enteredEmail: String = ""
    
    init(list: List) {
        self.list = list
        self.user = testUser
    }

    public func validateLinkAccounts() -> String? {
        guard enteredEmail.isValidEmail() else { return ValidationError.invalidEmail.error }
        return nil
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popLinkAccountViewController()
    }
    
    public func handleRecentlySelectedUser(user: String) {
        logSuccess("Email: \(user)")
        self.actionDelegate.popLinkAccountViewController()
    }
    
    public func handleShareButtonTapped(_ sender: UIButton) -> String? {
        
        if let error = self.validateLinkAccounts() {
            return error
        }
        
        logSuccess("Email: \(self.enteredEmail)")
        
        return nil
        
    }
    
    public func handlePinTextFieldEntries(_ textField: UITextField, string: String) -> Bool {
        
        if string.count > 0 {
            let nextTag = textField.tag + 1

            let nextResponder = textField.superview?.viewWithTag(nextTag)
            
            textField.text = string
            nextResponder?.becomeFirstResponder()
            
            if (nextResponder == nil) {
                textField.resignFirstResponder()
            }
            
            return false
            
        } else if string.count == 0 {

            let previousTag = textField.tag - 1

            let previousResponder = textField.superview?.viewWithTag(previousTag)
            
            textField.text = ""
            
            textField.resignFirstResponder()
            
            previousResponder?.becomeFirstResponder()
            
            return false
            
        }
        
        textField.resignFirstResponder()
        return false

    }
    
    public func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        self.enteredEmail = text
        
    }
    
    public func customCollectionLayout() -> UICollectionViewLayout {
        
        let layout = TokenCollViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    public func sizeForCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        
        let text = self.recentlyShared[indexPath.row]
        
        let textWidth = (text as NSString).boundingRect(
            with: CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude),
            options: [],
            attributes: [.font: UIFont(name: avenirNextBold, size: 18.0) ?? ""],
            context: nil
        ).size.width
        
        return CGSize(width: ceil(textWidth + 34), height: 35)
        
    }
    
}
