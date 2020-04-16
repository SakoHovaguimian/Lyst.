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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK:- Properties
    
    private(set) var loginViewModel: LoginViewModel!
    
    //MARK:- Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = " LYST."
        label.textAlignment = .center
        label.textColor = .charcoalBlack
        label.font = UIFont(name: avenirNextBold, size: 80.0)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "The last lyst you'll ever need"
        label.textAlignment = .center
        label.textColor = .charcoalBlack
        label.font = UIFont(name: avenirNextMedium, size: 18.0)
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 20.0)
        btn.addTarget(self,
                      action: #selector(self.submitButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        return configureDontHaveAccountButton()
    }()
    
    private let emailTextField = InputTextField(placeholder: "Email",
                                             secureEntry: false)
    
    private let passwordTextField = InputTextField(placeholder: "Password",
                                                   secureEntry: true)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    //MARK:- Helper Functions
    
    private func configureViews() {
        
        self.view.simpleGradient(colors: backgroundGradient)
        
        //Title Label
        self.view.addSubview(self.titleLabel)
        
        self.titleLabel.centerX(inView: self.view)
        self.titleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                               left: self.view.leftAnchor,
                               right: self.view.rightAnchor,
                               paddingTop: 32,
                               paddingLeft: 64,
                               paddingRight: 64,
                               height: 70)
        
        //Detail Label
        self.view.addSubview(self.detailLabel)
        
        self.detailLabel.centerX(inView: self.view)
        self.detailLabel.anchor(top: self.titleLabel.bottomAnchor,
                               left: self.view.leftAnchor,
                               right: self.view.rightAnchor,
                               paddingTop: 8,
                               paddingLeft: 64,
                               paddingRight: 64,
                               height: 20)
        
        
        //Email TextField
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.delegate = self
        
        self.emailTextField.centerY(inView: self.view, constant: -50)
        self.emailTextField.anchor(left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
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
        
        //DontHaveAccountButton
        self.view.addSubview(self.dontHaveAccountButton)
        
        self.dontHaveAccountButton.anchor(left: self.view.leftAnchor,
                                          bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                          right: self.view.rightAnchor,
                                          paddingLeft: 32,
                                          paddingBottom: 0,
                                          paddingRight: 32,
                                          height: 20)
        
    }
    
    private func configureDontHaveAccountButton() -> UIButton {
        
        let btn = UIButton(type: .system)
        
        let font1 = UIFont(name: avenirNextRegular, size: 15.0)
        let font2 = UIFont(name: avenirNextMedium, size: 15.0)
        let text1 = "Don't have an account? "
        let text2 = " Sign Up!"
        
        let attributedString = String().customAttributedString(text1,
                                                               text2,
                                                               font1: font1,
                                                               font2: font2,
                                                               font1Size: 15.0,
                                                               font2Size: 15.0,
                                                               color1: .darkGray,
                                                               color2: .systemBlue)
        
        btn.setAttributedTitle(attributedString, for: .normal)
        
        btn.addTarget(self,
                      action: #selector(self.signUpButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
        
    }
    
    //MARK:- OBJC Functions
    @objc private func submitButtonTapped(_ sender: UIButton) {
        self.loginViewModel.handleCloseButtonTapped(sender)
    }
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        self.loginViewModel.handleSignUpButtonTapped(sender)
    }
    
}

//MARK:- Extensions

//MARK:- Textfield Delegates
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            self.loginViewModel.email = textField.text ?? ""
        } else {
            self.loginViewModel.password = textField.text ?? ""
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
