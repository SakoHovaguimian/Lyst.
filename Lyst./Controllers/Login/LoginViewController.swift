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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "LYST."
        label.textAlignment = .center
        label.textColor = .charcoalBlack
        label.font = UIFont(name: avenirNextBold, size: 80.0)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        self.configureTextField(isSecure: false)
    }()
    
    private lazy var passwordTextField: UITextField = {
        self.configureTextField(isSecure: true)
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
        
        //Email TextField
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.centerY(inView: self.view, constant: -50)
        self.emailTextField.anchor(left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingLeft: 32,
                                   paddingRight: 32,
                                   height: 50)
        
        //Password TextField
        self.view.addSubview(self.passwordTextField)
        
        self.passwordTextField.anchor(top: self.emailTextField.bottomAnchor,
                                   left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingTop: 16,
                                   paddingLeft: 32,
                                   paddingRight: 32,
                                   height: 50)
        
    }
    
    private func configureTextField(isSecure: Bool) -> UITextField {
        
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.delegate = self
        tf.backgroundColor = .lighterGray
        tf.textColor = .charcoalBlack
        tf.isSecureTextEntry = isSecure
        tf.font = UIFont(name: avenirNextBold, size: 15.0)
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        tf.leftViewMode = .always
        tf.addShadow(shadow: .black,
                     opacity: 0.5, offSet: .zero, raidus: 1.0)
        tf.attributedPlaceholder = NSAttributedString(string: isSecure ? "Password" : "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return tf
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
