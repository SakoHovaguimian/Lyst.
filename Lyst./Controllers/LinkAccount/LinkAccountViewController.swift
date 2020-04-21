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
    
    private lazy var pinStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Email",
                                       secureEntry: false,
                                       tag: 0)
        textField.delegate = self
        return textField
    }()
    
    let pinTextField1 = PinTextField(tag: 1)
    let pinTextField2 = PinTextField(tag: 2)
    let pinTextField3 = PinTextField(tag: 3)
    let pinTextField4 = PinTextField(tag: 4)
    
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
        
        self.configurePinTextFields()
        
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
    
    private func configurePinTextFields() {

        //Stack View
        self.view.addSubview(self.pinStackView)
        
        self.pinTextField1.delegate = self
        self.pinTextField2.delegate = self
        self.pinTextField3.delegate = self
        self.pinTextField4.delegate = self
        
        self.pinStackView.addArrangedSubview(self.pinTextField1)
        self.pinStackView.addArrangedSubview(self.pinTextField2)
        self.pinStackView.addArrangedSubview(self.pinTextField3)
        self.pinStackView.addArrangedSubview(self.pinTextField4)
        
        self.pinStackView.anchor(top: self.emailTextField.bottomAnchor,
                                 left: self.view.leftAnchor,
                                 right: self.view.rightAnchor,
                                 paddingTop: 16,
                                 paddingLeft: 32,
                                 paddingRight: 32,
                                 height: 60)
        
        
        
    }
    
    private func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        self.linkAccountViewModel.enteredEmail = text
        
    }
    
    private func updatePin() {
        
        self.linkAccountViewModel.createPin(textFields: [
            self.pinTextField1,
            self.pinTextField2,
            self.pinTextField3,
            self.pinTextField4
        ])
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.linkAccountViewModel.handleBackButtonTapped(sender)
    }
    
}

    //MARK:- Extensions

extension LinkAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.emailTextField {
            self.updateTextFieldForViewModel(emailTextField, string: string)
            return true
        }
        
        return self.linkAccountViewModel.handlePinTextFieldEntries(textField, string: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            self.updateTextFieldForViewModel(self.emailTextField, string: nil)
        } else {
            self.updatePin()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}