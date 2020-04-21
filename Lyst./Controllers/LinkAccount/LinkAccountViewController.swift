//
//  ItemsViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class LinkAccountViewController: UIViewController {
    
    //MARK:- Properties
    
    private var linkAccountViewModel: LinkAccountViewModel!
    
    //MARK:- Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = " Link Accounts "
        label.textAlignment = .center
        label.textColor = .charcoalBlack
        label.font = UIFont(name: avenirNextBold, size: 40.0)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Start sharing your lysts"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 18.0)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .charcoalBlack
        btn.addTarget(self,
                      action: #selector(self.backButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Email",
                                       secureEntry: false,
                                       tag: 0)
        textField.delegate = self
        return textField
    }()
    
    //MARK:- Life Cycle
    
    init(viewModel: LinkAccountViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.linkAccountViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViews()
        
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.view.backgroundColor = .white

        self.configureAlphaView()
        self.configureButtons()
        self.configureLabels()
        self.configureTextFields()
        
    }
    
    private func configureAlphaView() {
        
        let vw = UIView()
        vw.alpha = 0.8
        vw.backgroundColor = .white
        
        self.view.addSubview(vw)
        
        vw.anchor(top: self.view.topAnchor,
                  left: self.view.leftAnchor,
                  right: self.view.rightAnchor,
                  height: self.view.frame.height / 8.6)
        
    }
    
    private func configureLabels() {
        
        //Title Label
        self.view.addSubview(self.titleLabel)
        
        self.titleLabel.anchor(top: self.closeButton.bottomAnchor,
                               left: self.view.leftAnchor,
                               right: self.view.rightAnchor,
                               paddingTop: 22,
                               paddingLeft: 64,
                               paddingRight: 64,
                               height: 50)
        
        //Detail View
        self.view.addSubview(self.detailLabel)
        
        self.detailLabel.anchor(top: self.titleLabel.bottomAnchor,
                                left: self.titleLabel.leftAnchor,
                                right: self.titleLabel.rightAnchor,
                                paddingTop: 0,
                                paddingLeft: 16,
                                paddingRight: 16,
                                height: 30)
        
    }
    
    private func configureButtons() {

        //Close Button
        self.view.addSubview(self.closeButton)
        
        self.closeButton.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                               right: self.view.rightAnchor,
                               paddingTop: 16,
                               paddingRight: 16,
                               width: 40,
                               height: 40)
        
    }
    
    private func configureTextFields() {
        
        //Email TextField
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.anchor(top: self.detailLabel.bottomAnchor,
                                   left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingTop: 40,
                                   paddingLeft: 32,
                                   paddingRight: 32,
                                   height: 50)
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.linkAccountViewModel.handleBackButtonTapped(sender)
    }
    
}

    //MARK:- Extensions

extension LinkAccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
