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
    
    private lazy var itemNameTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Item Name",
                                       secureEntry: false,
                                       tag: 0)
        textField.delegate = self
        textField.font = UIFont(name: avenirNextBold, size: 20.0)
        return textField
    }()
    
    private let itemNameDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Item Name"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 14.0)
        return label
    }()
    
    var textFields: [UITextField] = []
    
    //MARK:- Life Cycle
    init(viewModel: AddItemViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.addItemViewModel = viewModel
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
        
        self.animateAlphaView(value: 0.5)

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
                             height: self.view.frame.height / 1.8)
        
        self.cardView.backgroundColor = .white
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 1.8)
        self.cardView.applyGradient(colors: backgroundGradient, frame: frame)
        
        self.cardView.layer.cornerRadius = 23
        
        self.configureButtons()
        self.configureTextFields()
        self.configureSubmitButton()
        
    }
    
    
    private func configureButtons() {
        
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

    }
    
    private func configureSubmitButton() {
        
        //Submit Button
        self.cardView.addSubview(self.submitButton)
        
        self.submitButton.anchor(top: self.itemNameTextField.bottomAnchor,
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
    
    private func updateTextFieldForViewModel(_ textField: UITextField, string: String?) {
        
        var text = (textField.text ?? "")
        
        text = string == "" ? String(text.dropLast()) : text + (string ?? "")
        
        self.addItemViewModel.item.name = text
        
    }
    
    private func addDismissGestureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(self.alphaViewTapped))
        self.alphaView.addGestureRecognizer(tap)
        
    }
    
    private func animateAlphaView(value: CGFloat, instant: Bool = false) {
        
        guard instant == false else {
            self.alphaView.alpha = 0.0
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.alphaView.alpha = value
        })
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.animateAlphaView(value: 0.0, instant: true)
        self.addItemViewModel.handleCloseButtonTapped(sender)
    }
    
    @objc private func createItemButtonTapped(_ sender: UIButton) {
        self.addItemViewModel.handleCreateItemButtonTapped(sender)
        logSuccess("CREATED Item Item: \(self.addItemViewModel.item.name)")
        
    }
    
    @objc private func alphaViewTapped() {
        self.animateAlphaView(value: 0.0, instant: true)
        self.addItemViewModel.handleOutsideCardViewTapped()
    }
    
}

//MARK:- Extension

//MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension AddItemViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.updateTextFieldForViewModel(self.itemNameTextField, string: string)
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.updateTextFieldForViewModel(self.itemNameTextField, string: nil)
        self.updateButtonState(self.textFields, self.submitButton)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
}
