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
    
    private(set) var user: User? = nil
    
    public var email: String = ""
    public var password: String = ""
    
    public func updateUser(withUser user: User) {
        self.user = user
    }

    public func handleSignUpButtonTapped(_ sender: UIButton) {
        self.actionDelegate.pushSignUpVC()
    }
    
    public func handleCloseButtonTapped(_ sender: UIButton) {
        self.actionDelegate.dismissLoginVC(user: testUser)
    }
    
}
