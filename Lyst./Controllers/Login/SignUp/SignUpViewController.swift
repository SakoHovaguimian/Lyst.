//
//  SignUpViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK:- Properties
    private(set) var signUpViewModel: SignUpViewModel!
    
    //MARK:- Views
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 20.0)
        btn.addTarget(self,
                      action: #selector(self.signUpButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(.charcoalBlack, for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 18.0)
        btn.addTarget(self,
                      action: #selector(self.backButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private let emailTextField = InputTextField(placeholder: "Email",
                                                secureEntry: false)
    
    private let passwordTextField = InputTextField(placeholder: "Password",
                                                   secureEntry: true)
    
    private let fullNameTextField = InputTextField(placeholder: "Full Name", secureEntry: false)
    
    
    //MARK:- Life Cycle
    
    init(viewModel: SignUpViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.signUpViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViews()
        self.configureBackButtonView()
        
    }
    
    //MARK:- Helper Functions
    
    private func configureViews() {
        
        self.view.simpleGradient(colors: backgroundGradient.reversed())
        
        
        //FullName TextField
        self.view.addSubview(self.fullNameTextField)
        
        self.fullNameTextField.delegate = self
        
        self.fullNameTextField.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 128,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 50)
        
        //Email TextField
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.delegate = self
        
        self.emailTextField.anchor(top: self.fullNameTextField.bottomAnchor,
                                   left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 32,
                                   paddingRight: 32,
                                   height: 50)
        
        //Password TextField
        self.view.addSubview(self.passwordTextField)
        
        self.passwordTextField.delegate = self
        
        self.passwordTextField.anchor(top: self.emailTextField.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 16,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 50)
        
        //Submit Button
        self.view.addSubview(self.submitButton)
        
        self.submitButton.anchor(top: self.passwordTextField.bottomAnchor,
                                 left: self.view.leftAnchor,
                                 right: self.view.rightAnchor,
                                 paddingTop: 64,
                                 paddingLeft: 32,
                                 paddingRight: 32,
                                 height: 60)
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 64, height: 60)
        self.submitButton.applyGradient(colors: [.skyBlue, .systemBlue], frame: frame)
        
        self.submitButton.roundCorners(.allCorners, radius: 11)
    }
    
    private func configureBackButtonView() {
        
        //Back ImageView
        
        let image = UIImage(named: "back2")?.withRenderingMode(.alwaysTemplate)
        let backImageView = UIImageView(image: image)
        backImageView.contentMode = .scaleAspectFill
        backImageView.clipsToBounds = true
        backImageView.tintColor = .charcoalBlack
        
        self.view.addSubview(backImageView)
        
        backImageView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                             left: self.view.leftAnchor,
                             paddingTop: 16,
                             paddingLeft: 16,
                             width: 20,
                             height: 20)
        
        //Back Button
        self.view.addSubview(self.backButton)
        
        self.backButton.anchor(top: backImageView.topAnchor,
                               left: backImageView.leftAnchor,
                               bottom: backImageView.bottomAnchor,
                               right: backImageView.rightAnchor,
                               paddingRight: -60)
        
        
    }
    
    //MARK:- @OBJC Functions
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        self.signUpViewModel.handleSignUpButtonTapped(sender)
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.signUpViewModel.handleBackButtonTapped(sender)
    }
    
}

//MARK:- Extensions

//MARK:- TextField Delegate

extension SignUpViewController: UITextFieldDelegate {
    
    
    
}
