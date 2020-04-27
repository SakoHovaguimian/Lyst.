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
    
    private var textFields: [UITextField] = []
    
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
                                                secureEntry: false, tag: 0)
    
    private let passwordTextField = InputTextField(placeholder: "Password",
                                                   secureEntry: true, tag: 1)
    
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
        
        self.textFields = [self.emailTextField, self.passwordTextField]
        
        self.configureViews()
        self.configureTextFieldsWithToolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.shouldPresentLoadingView(false)
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
        
        self.updateButtonState(self.textFields, self.submitButton)
        
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
    
    private func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        if textField == self.emailTextField {
            self.loginViewModel.email = text
        } else {
            self.loginViewModel.password = text
        }
        
    }
    
    private func configureTextFieldsWithToolBar() {
        
        let toolbar1 = InputAccessoryView(items: [.next], textField: self.emailTextField, delegate: self)
        let toolbar2 = InputAccessoryView(items: [.previous, .flexibleSpace, .done], textField: self.passwordTextField, delegate: self)
        
        self.emailTextField.inputAccessoryView = toolbar1
        self.emailTextField.returnKeyType = .next
        
        self.passwordTextField.inputAccessoryView = toolbar2
        self.passwordTextField.returnKeyType = .done
        
    }
    
    //MARK:- OBJC Functions
    @objc private func submitButtonTapped(_ sender: UIButton) {
        
        self.shouldPresentLoadingView(true)
        
        self.loginViewModel.handleLoginButtonTapped(completion: { error in
            
            if let error = error {
                
                self.shouldPresentLoadingView(false)
                self.showSimpleError(title: "Error", message: error)
                
            }
            
        })
        
    }
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        self.loginViewModel.handleSignUpButtonTapped(sender)
    }
    
}

//MARK:- Extensions

//MARK:- TextField ToolBar Delegate
extension LoginViewController: InputAccessoryViewDelegate {
    
    func didTapNextButton(_ sender: UITextField) {
        self.passwordTextField.becomeFirstResponder()
    }
    
    func didTapPreviousButton(_ sender: UITextField) {
        self.emailTextField.becomeFirstResponder()
    }
    
    func didTapDoneButton(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
}

//MARK:- Textfield Delegates
extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.updateTextFieldForViewModel(textField, string: string)
        self.updateButtonState(self.textFields, self.submitButton)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateButtonState(self.textFields, self.submitButton)
        self.updateTextFieldForViewModel(textField, string: nil)
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
