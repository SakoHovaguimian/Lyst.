//
//  ItemsViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class AddListViewController: UIViewController {
    
    //MARK:- Properties
    
    private var addListViewModel: AddListViewModel!
    
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
        btn.setTitle("Create Lyst", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 20.0)
        btn.addTarget(self,
                      action: #selector(self.createListButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var listNameTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Lyst Name",
                                       secureEntry: false,
                                       tag: 0)
        textField.delegate = self
        textField.font = UIFont(name: avenirNextBold, size: 20.0)
        return textField
    }()
    
    private let listNameDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Lyst Name"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 14.0)
        return label
    }()
    
    private lazy var listCategoryTextField: InputTextField = {
        let textField = InputTextField(placeholder: "Category",
                                       secureEntry: false,
                                       tag: 1)
        textField.delegate = self
        textField.inputView = self.categoryPickerView
        textField.text = Category.allCases[0].name
        textField.font = UIFont(name: avenirNextBold, size: 20.0)
        return textField
    }()
    
    private let listCategoryDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Lyst Category"
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont(name: avenirNextMedium, size: 14.0)
        return label
    }()
    
    var textFields: [UITextField] = []
    
    //MARK:- Life Cycle
    init(viewModel: AddListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.addListViewModel = viewModel
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
        
        self.addListViewModel.animateAlphaFor(self.alphaView,value: 0.5)
        
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.textFields = [self.listNameTextField]
        self.updateButtonState(self.textFields, self.submitButton)
        
        self.configurePickerView()
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
        
        //List Name Description
        self.cardView.addSubview(self.listNameDescLabel)
        
        self.listNameDescLabel.anchor(top: self.closeButton.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 32,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 20)
        
        //List Name
        self.cardView.addSubview(self.listNameTextField)
        
        self.listNameTextField.anchor(top: self.listNameDescLabel.bottomAnchor,
                                      left: self.view.leftAnchor,
                                      right: self.view.rightAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 32,
                                      paddingRight: 32,
                                      height: 50)
        
        //List Category Description
        self.cardView.addSubview(self.listCategoryDescLabel)
        
        self.listCategoryDescLabel.anchor(top: self.listNameTextField.bottomAnchor,
                                          left: self.view.leftAnchor,
                                          right: self.view.rightAnchor,
                                          paddingTop: 16,
                                          paddingLeft: 32,
                                          paddingRight: 32,
                                          height: 20)
        
        //List Category
        self.cardView.addSubview(self.listCategoryTextField)
        
        self.listCategoryTextField.anchor(top: self.listCategoryDescLabel.bottomAnchor,
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
        
        self.submitButton.anchor(top: self.listCategoryTextField.bottomAnchor,
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
    
    private func configurePickerView() {
        
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.pickerViewDoneButtonTapped))
        
        let barAccessory = UIToolbar(frame: CGRect(x: 0, y: -10, width: self.view.frame.width, height: 44))
        barAccessory.barStyle = .default
        barAccessory.isTranslucent = false
        barAccessory.isUserInteractionEnabled = true
        barAccessory.items = [doneButton]
        
        self.listCategoryTextField.inputAccessoryView = barAccessory
        
    }
    
    private func addDismissGestureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(self.alphaViewTapped))
        self.alphaView.addGestureRecognizer(tap)
        
    }
    
    //MARK:- @OBJC Functions
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.addListViewModel.animateAlphaFor(self.alphaView,value: 0.0, instant: true)
        self.addListViewModel.handleCloseButtonTapped(sender)
    }
    
    @objc private func createListButtonTapped(_ sender: UIButton) {
        self.addListViewModel.handleCreateListButtonTapped(sender)
        logSuccess("CREATED LIST LIST: \(self.addListViewModel.list.name)")
        
    }
    
    @objc private func alphaViewTapped() {
        self.addListViewModel.animateAlphaFor(self.alphaView,value: 0.0, instant: true)
        self.addListViewModel.handleOutsideCardViewTapped()
        logSuccess("SHARING ACCOUNT WITH...")
        
    }
    
    @objc private func pickerViewDoneButtonTapped() {
        self.listCategoryTextField.resignFirstResponder()
    }
    
}

//MARK:- Extension

//MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension AddListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.addListViewModel.updateTextFieldForViewModel(self.listNameTextField, string: string)
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.addListViewModel.updateTextFieldForViewModel(self.listNameTextField, string: nil)
        self.updateButtonState(self.textFields, self.submitButton)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.updateButtonState(self.textFields, self.submitButton)
        return true
        
    }
    
}

//MARK:- PICKER VIEW DELEGATE & DATASOURCE
extension AddListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].name
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.addListViewModel.categorySelectedRow = row
        let category = Category.allCases[self.addListViewModel.categorySelectedRow]
        
        self.listCategoryTextField.text = category.name
        self.addListViewModel.list.category = Category(rawValue: category.rawValue)!
        
    }
}
