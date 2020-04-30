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
    
    private var textFields: [UITextField] = []
    
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
    
    private let partnerEmailDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Email"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 12.0)
        return label
    }()
    
    private let partnerPinDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Partner Pin Code"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 12.0)
        return label
    }()
    
    private let sharedUsersDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Recently Shared With"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 16.0)
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
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Link", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 20.0)
        btn.addTarget(self,
                      action: #selector(self.submitButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Email",
                                       secureEntry: false,
                                       tag: 0)
        textField.delegate = self
        textField.font = UIFont(name: avenirNextBold, size: 20.0)
        return textField
    }()
    
    private lazy var linkedAccountsCollectionView: UICollectionView = {
        let layout = self.linkAccountViewModel.customCollectionLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.register(UINib(nibName: LinkedAccountsCollectionViewCell.identifier,
                          bundle: nil),
                    forCellWithReuseIdentifier: LinkedAccountsCollectionViewCell.identifier)
        return cv
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
        self.updateButtonState(self.textFields, self.submitButton)
        
        logSuccess(self.linkAccountViewModel.list.name)
        
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.view.backgroundColor = .clear
        
        self.view.simpleGradient(colors: backgroundGradient)
        
        //        self.configureAlphaView()
        self.configureButtons()
        self.configureLabels()
        self.configureTextFields()
        
        self.configureSubmitButton()
        
        self.configureCollectionView()
        
        self.textFields = [
            self.emailTextField
        ]
        
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
                               paddingTop: 16,
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
        
        //Partner Email Description
        self.view.addSubview(self.partnerEmailDescLabel)
        
        self.partnerEmailDescLabel.anchor(top: self.detailLabel.topAnchor,
                                          left: self.view.leftAnchor,
                                          right: self.view.rightAnchor,
                                          paddingTop: 45,
                                          paddingLeft: 32,
                                          paddingRight: 32,
                                          height: 20)
        
        //Email TextField
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.anchor(top: self.partnerEmailDescLabel.bottomAnchor,
                                   left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingTop: 0,
                                   paddingLeft: 32,
                                   paddingRight: 32,
                                   height: 50)
        
    }
    
    private func configureSubmitButton() {
        
        //Submit Button
        self.view.addSubview(self.submitButton)
        
        self.submitButton.anchor(top: self.emailTextField.bottomAnchor,
                                 left: self.view.leftAnchor,
                                 right: self.view.rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 32,
                                 paddingRight: 32,
                                 height: 50)
        
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 64, height: 60)
        self.submitButton.applyGradient(colors: [.skyBlue, .systemBlue], frame: frame)
        
        self.submitButton.roundCorners(.allCorners, radius: 11)
        
    }
    
    private func configureCollectionView() {
        
        guard !self.linkAccountViewModel.recentlyShared.isEmpty else { return }
        
        //Shared User Desc Label
        self.view.addSubview(self.sharedUsersDescLabel)
        
        self.sharedUsersDescLabel.anchor(top: self.submitButton.bottomAnchor,
                                         left: self.submitButton.leftAnchor,
                                         right: self.submitButton.rightAnchor,
                                         paddingTop: 30,
                                         height: 20)
        
        //Collection View
        self.view.addSubview(self.linkedAccountsCollectionView)
        
        self.linkedAccountsCollectionView.anchor(top: self.sharedUsersDescLabel.bottomAnchor,
                                                 left: self.submitButton.leftAnchor,
                                                 bottom: self.view.bottomAnchor,
                                                 right: self.submitButton.rightAnchor,
                                                 paddingTop: 5,
                                                 paddingBottom: 16)
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.linkAccountViewModel.handleBackButtonTapped(sender)
    }
    
    @objc private func submitButtonTapped(_ sender: UIButton) {
        
        self.shouldPresentLoadingView(true)
        
        self.linkAccountViewModel.handleShareButtonTapped { error in
            
            self.shouldPresentLoadingView(false)
            
            if let error = error {
                self.showSimpleError(title: "Error", message: "\(error)")
            }
            
        }
        
        logSuccess("SHARING ACCOUNT WITH...")
        
    }
    
}

//MARK:- Extension

//MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension LinkAccountViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.linkAccountViewModel.updateTextFieldForViewModel(self.emailTextField, string: string)
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.linkAccountViewModel.updateTextFieldForViewModel(self.emailTextField, string: nil)
        self.updateButtonState(self.textFields, self.submitButton)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
}

//MARK:- COLLECTION VIEW DELEGATE & DATASOURCE

extension LinkAccountViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.linkAccountViewModel.recentlyShared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.linkedAccountsCollectionView.dequeueReusableCell(withReuseIdentifier: LinkedAccountsCollectionViewCell.identifier, for: indexPath) as? LinkedAccountsCollectionViewCell {
            let name = self.linkAccountViewModel.recentlyShared[indexPath.row]
            cell.name = name
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.linkAccountViewModel.sizeForCollectionViewCell(self.linkedAccountsCollectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user = self.linkAccountViewModel.recentlyShared[indexPath.row]
        self.linkAccountViewModel.handleRecentlySelectedUser(user: user)
        
    }
    
}
