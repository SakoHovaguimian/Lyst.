//
//  ItemsViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class AddItemViewController: UIViewController {
    
    //MARK:- Properties
    
    private var addItemViewModel: AddItemViewModel!
    private var mediaDaddy: MediaDaddy!
    
    //MARK:- VIEWS
    
    private let categoryPickerView = UIPickerView()
    
    private lazy var alphaView: UIView = {
        let vw = UIView()
        vw.clipsToBounds = true
        vw.alpha = 0.0
        vw.backgroundColor = .black
        return vw
    }()
    
    private lazy var cardView: UIView = {
        let vw = UIView()
        vw.clipsToBounds = true
        return vw
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .charcoalBlack
        btn.addTarget(self,
                      action: #selector(self.closeButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var submitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create Item", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 20.0)
        btn.addTarget(self,
                      action: #selector(self.createItemButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var addImageButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.clipsToBounds = true
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate),
                     for: .normal)
        btn.tintColor = .lightGray
        btn.addTarget(self,
                      action: #selector(self.addImageButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    //MARK:- TEXTFIELDS
    private lazy var itemNameTextField: InputTextField = {
        return self.addItemViewModel.createInputTextField(placeholder: "Item Name", tag: 0, vc: self)
    }()
    
    private lazy var itemNameDescLabel: UILabel = {
        return self.addItemViewModel.createDescLabel(text: "Item Name")
    }()
    
    private lazy var itemLinkTextField: InputTextField = {
        return self.addItemViewModel.createInputTextField(placeholder: "Item Link(Optional)", tag: 1, vc: self)
    }()
    
    private lazy var itemLinkDescLabel: UILabel = {
        return self.addItemViewModel.createDescLabel(text: "Item Link")
    }()
    
    var textFields: [UITextField] = []
    
    //MARK:- Life Cycle
    init(viewModel: AddItemViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.addItemViewModel = viewModel
        self.mediaDaddy = MediaDaddy(presentationController: self, delegate: self, mediaType: .pics)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDismissGestureRecognizer()
        self.configureViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.addItemViewModel.animateAlphaFor(self.alphaView, value: 0.5)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.shouldPresentLoadingView(false)
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.textFields = [self.itemNameTextField]
        self.updateButtonState(self.textFields, self.submitButton)
        
        self.configureAlphaView()
        self.configureCardView()
        
    }
    
    private func configureAlphaView() {
        
        //Alpha View
        self.view.addSubview(self.alphaView)
        self.alphaView.addConstraintsToFillView(self.view)
        
    }
    
    private func configureCardView() {
        
        //Card View
        self.view.addSubview(self.cardView)
        
        self.cardView.anchor(left: self.view.leftAnchor,
                             bottom: self.view.bottomAnchor,
                             right: self.view.rightAnchor,
                             paddingBottom: -5,
                             height: self.view.frame.height / 1.5)
        
        self.cardView.backgroundColor = .white
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.5)
        self.cardView.applyGradient(colors: backgroundGradient, frame: frame)
        
        self.cardView.layer.cornerRadius = 23
        
        self.configureCloseButton()
        self.configureTextFields()
        self.configureAddImageButton()
        self.configureSubmitButton()
        
    }
    
    
    private func configureCloseButton() {
        
        //Close Button
        self.cardView.addSubview(self.closeButton)
        
        self.closeButton.anchor(top: self.cardView.safeAreaLayoutGuide.topAnchor,
                                right: self.view.rightAnchor,
                                paddingTop: 16,
                                paddingRight: 16,
                                width: 40,
                                height: 40)
        
    }
    
    
    private func configureTextFields() {
        
        //Item Name Description
        self.cardView.addSubview(self.itemNameDescLabel)
        
        self.itemNameDescLabel.anchor(top: self.closeButton.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 32,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 20)
        
        //Item Name
        self.cardView.addSubview(self.itemNameTextField)

        self.itemNameTextField.anchor(top: self.itemNameDescLabel.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 50)
        
        //Item Link Description
        self.cardView.addSubview(self.itemLinkDescLabel)
        
        self.itemLinkDescLabel.anchor(top: self.itemNameTextField.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 16,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 20)
        
        //Item Link
        self.cardView.addSubview(self.itemLinkTextField)

        self.itemLinkTextField.anchor(top: self.itemLinkDescLabel.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 50)

    }
    
    private func configureSubmitButton() {
        
        //Submit Button
        self.cardView.addSubview(self.submitButton)
        
        self.submitButton.anchor(top: self.addImageButton.bottomAnchor,
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
    
    private func configureAddImageButton() {
        
        //Add Image Button
        self.view.addSubview(self.addImageButton)
        
        self.addImageButton.anchor(top: self.itemLinkTextField.bottomAnchor,
                                   left: self.view.leftAnchor,
                                   right: self.view.rightAnchor,
                                   paddingTop: 32,
                                   paddingLeft: self.view.frame.width / 2.8,
                                   paddingRight: self.view.frame.width / 2.8,
                                   height: self.view.frame.height / 6)
        
        self.addImageButton.layer.borderColor = UIColor.lightGray.cgColor
        self.addImageButton.layer.borderWidth = 1.2
        self.addImageButton.layer.cornerRadius = 11
        
    }
    
    private func addDismissGestureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(self.alphaViewTapped))
        self.alphaView.addGestureRecognizer(tap)
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.addItemViewModel.animateAlphaFor(self.alphaView, value: 0.0, instant: true)
        self.addItemViewModel.handleCloseButtonTapped(sender)
    }
    
    @objc private func createItemButtonTapped(_ sender: UIButton) {
        self.shouldPresentLoadingView(true)
        self.addItemViewModel.handleCreateItemButtonTapped(sender)
        logSuccess("CREATED Item Item: \(self.addItemViewModel.item.name)")
        
    }
    
    @objc private func addImageButtonTapped(_ sender: UIButton) {
        self.mediaDaddy.present(from: self.view)
    }
    
    @objc private func alphaViewTapped() {
        self.addItemViewModel.animateAlphaFor(self.alphaView, value: 0.0, instant: true)
        self.addItemViewModel.handleOutsideCardViewTapped()
    }
    
}

//MARK:- Extension

//MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension AddItemViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.addItemViewModel.updateTextFieldForViewModel(textField, string: string)
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.addItemViewModel.updateTextFieldForViewModel(textField, string: nil)
        self.updateButtonState(self.textFields, self.submitButton)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
}

//MARK:- IMAGE PICKER MEDIA DADDY DELEGATE
extension AddItemViewController: MediaPickerDelegate {
    func didSelect(image: UIImage?) {
        if let image = image {
            self.addItemViewModel.selectedImage = image
            self.addImageButton.setImage(image, for: .normal)
        }
    }
    
    func didSelect(meida: URL?) {
        
    }
    
    
}
