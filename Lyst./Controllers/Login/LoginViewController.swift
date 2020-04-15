//
//  HomeViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class LoginViewController: UIViewController {
    
    //MARK:- Properties
    
    private var loginViewModel: LoginViewModel!
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .charcoalBlack
        btn.clipsToBounds = true
        btn.setImage(UIImage(systemName: "stop"), for: .normal)
        btn.addTarget(self,
                      action: #selector(self.closeButtonTapped(sender:)),
                      for: .touchUpInside)
        return btn
    }()
    
    //MARK:- Views
    
    //MARK:- Life Cycle
    
    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.loginViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.configureViews()
    }
    
    //MARK:- Helper Functions
    
    private func configureViews() {
        
        //Close Button
        self.view.addSubview(self.closeButton)
        
        self.closeButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                right: self.view.rightAnchor,
                                paddingTop: 8,
                                paddingRight: 16,
                                width: 32,
                                height: 32)
        
    }
    
    //MARK:- @BJC Functions
    @objc private func closeButtonTapped(sender: UIButton) {
        self.loginViewModel.handleCloseButtonTapped(sender)
    }
    
 
}
