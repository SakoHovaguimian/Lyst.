//
//  HomeCoordinator.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        
        let viewModel = HomeViewModel()
        viewModel.loginDelegate = self
        
        let homeVC = HomeViewController(viewModel: viewModel)
            
        self.navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.pushViewController(homeVC, animated: false)
        
    }
    
    private func presentLoginCoordinator(animated: Bool) {
        
        let nc = UINavigationController()
        
        let loginCoord = LoginCoordinator(navigationController: nc)
        loginCoord.userCreatedDelegate = self
        
        loginCoord.start()
        
        self.navigationController.present(nc, animated: animated, completion: nil)
        
        self.childCoordinators.append(loginCoord)
        
    }
    
}

extension HomeCoordinator: UserCreatedDelegate {
    
    func userCreated(user: User) {
        
        if let homeVC = self.navigationController.viewControllers.first as? HomeViewController {
            homeVC.homeViewModel.updateUser(withUser: user)
            self.childCoordinators.removeLast()
        }
        
    }
    
}

extension HomeCoordinator: PresentLoginViewControllerDelegate {
    
    func presentLoginVC(animated: Bool) {
        logDebugMessage("Coordinator is attemplting to log")
        self.presentLoginCoordinator(animated: animated)
    }
    
}
