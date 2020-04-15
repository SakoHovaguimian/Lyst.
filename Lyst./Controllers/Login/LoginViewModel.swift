//
//  HomeViewModel.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol DismissLoginViewControllerDelegate: class {
    func dismissLoginVC(user: User)
}

class LoginViewModel {

    weak var dismissLoginDelegate: DismissLoginViewControllerDelegate!
    
    private(set) var user: User? = nil
    
    public func updateUser(withUser user: User) {
        self.user = user
    }

    public func handleSignUpButtonTapped(_ sender: UIButton) {

    }
    
    public func handleLinkUpButtonTapped(_ sender: UIButton) {

    }
    
    public func handleCloseButtonTapped(_ sender: UIButton) {
        self.dismissLoginDelegate.dismissLoginVC(user: testUser)
    }
    
}
