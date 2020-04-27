//
//  HomeCoordinator.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo
import SafariServices

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
    
    private func presentLinkAccountViewController(list: List) {
        
        let viewModel = LinkAccountViewModel(list: list)
        viewModel.actionDelegate = self
        
        let itemVC = LinkAccountViewController(viewModel: viewModel)
        itemVC.modalPresentationStyle = .fullScreen
        
        self.navigationController.present(itemVC, animated: true)
        
        
    }
    
    private func presentAddListViewController() {
        
        let viewModel = AddListViewModel()
        viewModel.actionDelegate = self
        
        let addListVC = AddListViewController(viewModel: viewModel)
        addListVC.modalPresentationStyle = .overCurrentContext
        
        self.navigationController.present(addListVC, animated: true)
        
        
    }
    
    private func presentAddItemViewController(list: List) {
        
        let viewModel = AddItemViewModel(list: list)
        viewModel.actionDelegate = self
        
        let addListVC = AddItemViewController(viewModel: viewModel)
        addListVC.modalPresentationStyle = .overCurrentContext
        
        self.navigationController.present(addListVC, animated: true)
        
        
    }
    
    private func openSafari(withItem item: Item) {
        
        if let link = item.link {
            
            let validUrlString = link.hasPrefix("http") ? link : "http://\(link)"
            
            if let url = URL(string: validUrlString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            
        }
        
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
    
    func presentWebView(item: Item) {
        self.openSafari(withItem: item)
    }
    
    func openLinkAccountVC(list: List) {
        self.presentLinkAccountViewController(list: list)
    }
    
    func popItemViewController() {
        self.navigationController.popViewController(animated: true)
        logSuccess("POPPING ITEM VIEW CONTROLLER")
    }
    
    func presentAddItemVC(list: List) {
        self.presentAddItemViewController(list: list)
    }
    
}

//MARK:- LOGIN COORDINATOR DELEGATE
extension HomeCoordinator: UserCreatedDelegate {
    
    func userCreated(user: User) {
        
        if let homeVC = self.navigationController.viewControllers.first as? HomeViewController {
            homeVC.homeViewModel.updateUser(withUser: user)
            testUser = user
            self.childCoordinators.removeLast()
        }
        
    }
    
}

//MARK:- HOME VIEW MODEL DELEGATE
extension HomeCoordinator: HomeVCActionsDelegate {
    
    //    func pushLinkAccountVC(user: User) {
    //        self.presentLinkAccountViewController(user: user)
    //    }
    
    func pushItemVC(list: List) {
        self.pushItemViewController(list: list)
    }
    
    func presentAddListVC() {
        self.presentAddListViewController()
    }
    
    func presentLoginVC(animated: Bool) {
        logDebugMessage("Coordinator is attemplting to log")
        self.presentLoginCoordinator(animated: animated)
    }
    
    
}

//MARK:- ADD LIST VIEW MODEL DELEGATE
extension HomeCoordinator: AddListVCActionDelegate {
    
    func popAddListViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
        logSuccess("POPPING ADD LIST VIEW CONTROLLER")
    }
    
    func addCreatedList(_ list: List) {
        
        if let homeVC = self.navigationController.viewControllers.first as? HomeViewController {
            homeVC.homeViewModel.addList(list)
            homeVC.homeTableView.reloadData()
        }
        
        self.navigationController.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK:- ADD LIST VIEW MODEL DELEGATE
extension HomeCoordinator: AddItemVCActionDelegate {
    
    func popAddItemViewController() {
        self.navigationController.dismiss(animated: true, completion: nil)
        logSuccess("POPPING ADD LIST VIEW CONTROLLER")
    }
    
    func updateListItems(_ list: List) {
        
        if let homeVC = self.navigationController.viewControllers.first as? HomeViewController {
            
            var listToUpdate = homeVC.homeViewModel.user?.lists
            
            if let row = listToUpdate?.firstIndex(where: {$0.id == list.id}) {
                listToUpdate?[row] = list
            }
            
            homeVC.homeTableView.reloadData()
            
        }
        
        if let itemVC = self.navigationController.viewControllers.last as? ItemsViewController {
            itemVC.itemsTableView.reloadData()
        }
        
        self.navigationController.dismiss(animated: true, completion: nil)
        
    }
    
}
