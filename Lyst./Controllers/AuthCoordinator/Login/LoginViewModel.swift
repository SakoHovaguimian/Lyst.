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
    
    public func handleLoginButtonTapped(completion: @escaping (String?) -> ()) {
        
        return self.handleLogin { error in
           completion(error)
        }
        
    }
    
    private func login(completion: @escaping (User?) -> ()) {
        
        UserService.login(email: self.email, password: self.password) { (user) in
            
            guard let user = user else { completion(nil); return }
            
            completion(user)
            
        }
        
    }
    
    private func validateTextFields() -> String? {
        
        guard email.count > 2 else { return ValidationError.invalidEmail.error }
        guard email.isValidEmail() else { return ValidationError.invalidEmail.error }
        guard password.count > 2 else { return ValidationError.invalidPassword.error }
        
        return nil
        
    }
    
    private func handleLogin(completion: @escaping (String?) -> Void) {
        
        if let validationError = self.validateTextFields() {
            return completion(validationError)
        }
        
        self.login { (user) in
            
            if let user = user {
                
                self.actionDelegate.dismissLoginVC(user: user)
                completion(nil)
                
            } else {
                
                completion("Incorrect Credentials")

            }
            
        }
        
    }
    
}
