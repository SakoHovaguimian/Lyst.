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
    
    private(set) var sharedUsers = [
        "Sako Hovaguimian",
        "Mithc Treece",
        "Libby Bibona",
        "Christopher Carl Bibona"
    ].sorted(by: { $0.count < $1.count })
    
    public var pin: String {
        return "\(user.pin)"
    }
    
    public var enteredPin: String = "0000"
    public var enteredEmail: String = ""
    
    
    init(user: User) {
        self.user = user
    }

    public func validateLinkAccounts() -> String? {
        
        guard enteredEmail.isValidEmail() else { return ValidationError.invalidEmail.error }
        guard enteredPin.count == 4 else { return ValidationError.invalidPin.error }
        
        return nil
        
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popLinkAccountViewController()
    }
    
    public func handleShareButtonTapped(_ sender: UIButton) -> String? {
        
        if let error = self.validateLinkAccounts() {
            return error
        }
        
        logSuccess("Email: \(self.enteredEmail), Pin: \(self.enteredPin)")
        
        return nil
        
    }
    
    public func createPin(textFields: [UITextField]) {
        let pin = textFields.map({($0.text ?? "0")}).joined(separator: "")
        self.enteredPin = pin
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
    
    public func customCollectionLayout() -> UICollectionViewLayout {
        
        let layout = TokenCollViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    public func sizeForCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        
        let text = self.sharedUsers[indexPath.row]
        
        let textWidth = (text as NSString).boundingRect(
            with: CGSize(width: collectionView.bounds.width, height: .greatestFiniteMagnitude),
            options: [],
            attributes: [.font: UIFont(name: avenirNextBold, size: 18.0) ?? ""],
            context: nil
        ).size.width
        
        return CGSize(width: ceil(textWidth + 34), height: 35)
        
    }
    
    public func deleteSharedUserAlert(vc: LinkAccountViewController, indexPath: IndexPath, completion: @escaping () -> ()) {
        
        let alert = UIAlertController(title: "Remove Linked Account",
                                      message: "All data will not be removed from linked account.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.sharedUsers.remove(at: indexPath.row)
            completion()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              logError("Canceled Deleting User")
        }))

        vc.present(alert, animated: true, completion: nil)
        
    }
    
}
