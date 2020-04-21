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
        viewModel.actionDelegate = self
        
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
    
    private func pushItemViewController(list: List) {
        
        let viewModel = ItemsViewModel(list: list)
        viewModel.actionDelegate = self
        
        let itemVC = ItemsViewController(viewModel: viewModel)
        
        self.navigationController.pushViewController(itemVC, animated: true)
        
        
    }
    
    private func pushLinkAccountViewController(user: User) {
        
        let viewModel = LinkAccountViewModel(user: user)
        viewModel.actionDelegate = self
        
        let itemVC = LinkAccountViewController(viewModel: viewModel)
        itemVC.modalPresentationStyle = .fullScreen
        
        self.navigationController.present(itemVC, animated: true)
        
        
    }
    
}

//MARK:- LINK ACTION VIEW MODEL DELEGATE
extension HomeCoordinator: LinkVCActionDelegate {
    
    func popLinkAccountViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
        logSuccess("POPPING LINK ACCOUNT VIEW CONTROLLER")
    }
    
}

//MARK:- ITEM VIEW MODEL DELEGATE
extension HomeCoordinator: ItemVCActionDelegate {
    
    func popItemViewController() {
        self.navigationController.popViewController(animated: true)
        logSuccess("POPPING ITEM VIEW CONTROLLER")
    }
    
}

//MARK:- LOGIN COORDINATOR DELEGATE
extension HomeCoordinator: UserCreatedDelegate {
    
    func userCreated(user: User) {
        
        if let homeVC = self.navigationController.viewControllers.first as? HomeViewController {
            homeVC.homeViewModel.updateUser(withUser: user)
            self.childCoordinators.removeLast()
        }
        
    }
    
}

//MARK:- HOME VIEW MODEL DELEGATE
extension HomeCoordinator: HomeVCActionsDelegate {
    
    func pushLinkAccountVC(user: User) {
        self.pushLinkAccountViewController(user: user)
    }
    
    func pushItemVC(list: List) {
        self.pushItemViewController(list: list)
    }
    
    
    func presentLoginVC(animated: Bool) {
        logDebugMessage("Coordinator is attemplting to log")
        self.presentLoginCoordinator(animated: animated)
    }

    
}
