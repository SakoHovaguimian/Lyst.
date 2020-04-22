//
//  SignUpViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

enum ValidationError: String {
    
    case invalidEmail
    case invalidPassword
    case invalidName
    case invalidPin
    
    var error: String {
        
        switch self {
            case .invalidEmail: return "The email you entered is invalid or missing"
            case .invalidPassword: return "The password you used is too short or missing"
            case .invalidName: return "The name you entered is too short or missing"
            case .invalidPin: return "The pin you entered is invalid. Please try again."
        }
        
    }
    
}

protocol SignUpActionDelegate: class {
    func didCreateUser(user: User)
    func popSignUpVC()
}

class SignUpViewModel {

    weak var actionDelegate: SignUpActionDelegate!
    
    public var fullName: String = "" {
        didSet {
            print(self.fullName)
        }
    }
    
    public var email: String = ""
    public var password: String = ""
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popSignUpVC()
    }
    
    public func handleSignUpButtonTapped(_ sender: UIButton) -> String? {
        
        if let error = self.validateTextFields() {
            return error
        }
        
        let user = User(name: self.fullName,
                        email: self.email,
                        listId: "234")
        
        self.actionDelegate.didCreateUser(user: user)
        
        return nil
        
    }
    
    
    private func validateTextFields() -> String? {
        
        guard fullName.count > 2 else { return ValidationError.invalidName.error }
        guard email.count > 2 else { return ValidationError.invalidEmail.error }
        guard email.isValidEmail() else { return ValidationError.invalidEmail.error }
        guard password.count > 2 else { return ValidationError.invalidPassword.error }
        
        return nil
        
    }
    
}
