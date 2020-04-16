//
//  SignUpViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

protocol SignUpActionDelegate: class {
    func didCreateUser(user: User)
    func popSignUpVC()
}

class SignUpViewModel {

    weak var actionDelegate: SignUpActionDelegate!
    
    private(set) var user: User? = nil
    
    public var firstName: String = ""
    public var email: String = ""
    public var password: String = ""
    
    public func updateUser(withUser user: User) {
        self.user = user
    }

    public func handleSignUpButtonTapped(_ sender: UIButton) {
        self.actionDelegate.didCreateUser(user: testUser)
    }
    
    public func handleBackButtonTapped(_ sender: UIButton) {
        self.actionDelegate.popSignUpVC()
    }
    
}
