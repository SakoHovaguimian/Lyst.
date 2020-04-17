//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol LoginActionDelegate: class {
    func pushSignUpVC()
    func dismissLoginVC(user: User)
}

class LoginViewModel {

    weak var actionDelegate: LoginActionDelegate!
    
    public var email: String = ""
    public var password: String = ""

    public func handleSignUpButtonTapped(_ sender: UIButton) {
        self.actionDelegate.pushSignUpVC()
    }
    
    public func handleLoginButtonTapped(_ sender: UIButton) -> String? {

       if let error = self.validateTextFields() {
           return error
       }
        
        let user = User(name: "Sako Hovaguimian",
                        email: self.email,
                        listId: "234")
        
        self.actionDelegate.dismissLoginVC(user: user)
        
        return nil
        
    }
    
    private func validateTextFields() -> String? {
        
        guard email.count > 2 else { return ValidationError.invalidEmail.error }
        guard email.isValidEmail() else { return ValidationError.invalidEmail.error }
        guard password.count > 2 else { return ValidationError.invalidPassword.error }
        
        return nil
        
    }
    
}
