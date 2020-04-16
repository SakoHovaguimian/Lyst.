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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Getting Started"
        label.textAlignment = .left
        label.textColor = .charcoalBlack
        label.font = UIFont(name: avenirNextBold, size: 40.0)
        return label
    }()
    
    private let fullNameTextField = InputTextField(placeholder: "Full Name", secureEntry: false, tag: 0)
    
    private let emailTextField = InputTextField(placeholder: "Email",
                                                secureEntry: false, tag: 1)
    
    private let passwordTextField = InputTextField(placeholder: "Password",
                                                   secureEntry: true, tag: 2)
    
    
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
        
        self.configureBackButtonView()
        self.configureViews()
        
    }
    
    //MARK:- Helper Functions
    
    private func configureViews() {
        
        self.view.simpleGradient(colors: backgroundGradient.reversed())
        
        //Title Label
        self.view.addSubview(self.titleLabel)
        
        self.titleLabel.anchor(top: self.backButton.bottomAnchor,
                               left: self.backButton.leftAnchor,
                               right: self.view.rightAnchor,
                               paddingTop: 48,
                               paddingLeft: 0,
                               paddingRight: 32,
                               height: 50)
        
        //FullName TextField
        self.view.addSubview(self.fullNameTextField)
        
        self.fullNameTextField.delegate = self
        
        self.fullNameTextField.anchor(top: self.titleLabel.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 100,
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
                                 paddingTop: 100,
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
        if let error = self.signUpViewModel.handleSignUpButtonTapped(sender) {
            self.showSimpleError(title: "Error", message: error)
        }
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.signUpViewModel.handleBackButtonTapped(sender)
    }
    
    private func updateTextFieldForViewModel(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            self.signUpViewModel.email = textField.text ?? ""
        } else if textField == self.fullNameTextField {
            self.signUpViewModel.fullName = textField.text ?? ""
        } else {
            self.signUpViewModel.password = passwordTextField.text ?? ""
        }
        
    }
    
}

//MARK:- Extensions

//MARK:- TextField Delegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.updateTextFieldForViewModel(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.updateTextFieldForViewModel(textField)
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1
        
        if let nextTextField = textField.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
        
    }
    
    
}
