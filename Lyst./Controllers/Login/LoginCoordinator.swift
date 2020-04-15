//
//  HomeCoordinator.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol UserCreatedDelegate: class {
    func userCreated(user: User)
}

class LoginCoordinator: Coordinator {
    
    weak var userCreatedDelegate:  UserCreatedDelegate!
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        
        let viewModel = LoginViewModel()
        viewModel.dismissLoginDelegate = self
        
        let loginVC = LoginViewController(viewModel: viewModel)
        
        self.navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.pushViewController(loginVC, animated: false)
        
    }
    
}

extension LoginCoordinator: DismissLoginViewControllerDelegate {
    
    func dismissLoginVC(user: User) {
        logDebugMessage("Coordinator is attemplting to close")
        self.userCreatedDelegate.userCreated(user: user)
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
}
