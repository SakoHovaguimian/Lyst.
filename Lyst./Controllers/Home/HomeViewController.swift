//
//  HomeViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class HomeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK:- Properties
    
    private(set) var homeViewModel: HomeViewModel!
    
    //MARK:- Views
    
    private lazy var homeTableView: UITableView = {
        return self.setupTableView()
    }()
    
    private lazy var addButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .charcoalBlack
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "add"), for: .normal)
        btn.addTarget(self,
                      action: #selector(self.addButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tintColor = .lightGray
        btn.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate),
                     for: .normal)
        btn.addTarget(self,
                      action: #selector(self.settingsButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var listsButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.tintColor = .charcoalBlack
        btn.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate),
                     for: .normal)
        btn.addTarget(self,
                      action: #selector(self.listsButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.alpha = 0.0
        return stackView
    }()
    
    //SettingsButtons
    
    private lazy var logoutButton: UIButton = {
        let btn = self.createSettingsButton(text: "Logout")
        btn.addTarget(self,
                      action: #selector(self.logoutButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var linkAccountButton: UIButton = {
        let btn = self.createSettingsButton(text: "Link Account")
        btn.addTarget(self,
                      action: #selector(self.linkAccountButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingButton: UIButton = {
        let btn = self.createSettingsButton(text: "Settings")
        btn.addTarget(self,
                      action: #selector(self.settingButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    
    //MARK:- Life Cycle
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.homeViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeViewModel.updateUser(withUser: testUser)

        if self.homeViewModel.isUserAvailable {
            self.configureViews()
        } else {
            self.homeViewModel.presentLoginController()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        
        guard self.homeViewModel.user != nil else { return }
        guard self.view.subviews.isEmpty else { return }
        
        self.configureViews()
        
    }
    
    //MARK:- Helper Functions
    
    private func configureViews() {
        
        self.view.backgroundColor = .white
        
        self.configureTableView()
        self.configureAlphaView()
        self.configureButtons()
        self.configureSettingsStackView()
        
        self.homeViewModel.shouldHideTableView = false
        self.animateUISettingsButton()
        self.updateButtonState()
        
        self.listsButton.tintColor = .charcoalBlack
        
    }
    
    private func configureAlphaView() {
        
        let vw = UIView()
        vw.alpha = 0.70
        vw.backgroundColor = .white
        
        self.view.addSubview(vw)
        
        vw.anchor(left: self.view.leftAnchor,
                  bottom: self.view.bottomAnchor,
                  right: self.view.rightAnchor,
                  height: self.view.frame.height / 8.6)
        
    }
    
    private func configureButtons() {
        
        //Add Button
        self.view.addSubview(self.addButton)
        
        self.addButton.centerX(inView: self.view)
        self.addButton.anchor(bottom: self.view.bottomAnchor,
                              paddingBottom: 32,
                              width: 60,
                              height: 60)
        self.addButton.layer.cornerRadius = 30
        
        //Settings Button
        self.view.addSubview(self.settingsButton)
        
        self.settingsButton.anchor(bottom: self.view.bottomAnchor,
                                   right: self.view.rightAnchor,
                                   paddingBottom: 45,
                                   paddingRight: self.view.frame.width / 3 - 75,
                                   width: 32, height: 32)
        
        //List Button
        self.view.addSubview(self.listsButton)
        
        self.listsButton.anchor(left: self.view.leftAnchor,
                                bottom: self.view.bottomAnchor,
                                paddingLeft: self.view.frame.width / 3 - 75,
                                paddingBottom: 45,
                                width: 32, height: 32)
        
    }
    
    private func setupTableView() -> UITableView {
        
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.contentInsetAdjustmentBehavior = .never
        tv.register(UINib(nibName: ListTableViewCell.identifier,
                          bundle: nil),
                    forCellReuseIdentifier: ListTableViewCell.identifier)
        tv.register(UINib(nibName: TableHeaderView.identifier,
                          bundle: nil),
                    forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        return tv
        
    }
    
    private func configureTableView() {
        
        self.view.addSubview(self.homeTableView)
        
        self.homeTableView.addConstraintsToFillView(self.view)
        
    }
    
    private func updateButtonState() {
        self.settingsButton.tintColor = .lightGray
        self.listsButton.tintColor = .lightGray
    }
    
    private func animateUISettingsButton() {
        
        let shouldHide = self.homeViewModel.shouldHideTableView
        
        UIView.animate(withDuration: 0.3) {
            self.settingsStackView.alpha = shouldHide ? 1.0 : 0.0
            self.settingsStackView.transform = shouldHide ? .identity : CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.homeTableView.alpha = shouldHide ? 0.0  : 1.0
        }
        
    }
    
    private func configureSettingsStackView() {
        
        guard self.settingsStackView.arrangedSubviews.count == 0 else { return }
        
        self.view.addSubview(self.settingsStackView)
        
        self.settingsStackView.anchor(left: self.view.leftAnchor,
                                      bottom: self.addButton.topAnchor,
                                      right: self.view.rightAnchor,
                                      paddingLeft: 64,
                                      paddingBottom: 80,
                                      paddingRight: 64)
        
            
        self.settingsStackView.addArrangedSubview(self.settingButton)
        self.settingsStackView.addArrangedSubview(self.linkAccountButton)
        self.settingsStackView.addArrangedSubview(self.logoutButton)
        
        self.settingsStackView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        
    }
    
    private func createSettingsButton(text: String) -> UIButton {
        
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40.0)
        button.setTitleColor(.charcoalBlack, for: .normal)
        
        button.setDimmensions(height: 60, width: self.view.frame.width - 64)
        
        return button
        
    }
    
    //MARK:- @OBJC Functions

    @objc private func addButtonTapped(_ sender: UIButton) {
        self.homeViewModel.handleAddButtonTapped(sender)
    }
    
    @objc private func listsButtonTapped(_ sender: UIButton) {
        self.updateButtonState()
        self.homeViewModel.handleListsButtonTapped(sender)
        self.animateUISettingsButton()
    }
    
    @objc private func settingsButtonTapped(_ sender: UIButton) {
        self.updateButtonState()
        self.homeViewModel.handleSettingsButtonTapped(sender)
        self.animateUISettingsButton()
    }
    
    @objc private func logoutButtonTapped(_ sender: UIButton) {
        self.settingsStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.view.subviews.forEach({ $0.removeFromSuperview() })
        self.homeViewModel.handleLogOutButtonTapped(sender)
    }
    
    @objc private func settingButtonTapped(_ sender: UIButton) {
        self.homeViewModel.handleSettingButtonTapped(sender)
    }
    
    @objc private func linkAccountButtonTapped(_ sender: UIButton) {
        self.homeViewModel.handleLinkAccountButtonTapped(sender)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view != self.settingsStackView {
            self.homeViewModel.shouldHideTableView = false
            self.animateUISettingsButton()
            print("TAPPED REGION")
        }
    }

}

    //MARK:- Extensions

    //MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.homeTableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = Category.home.name
        self.homeViewModel.handlePushItemsViewController(list: category)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = self.homeTableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as! TableHeaderView
        vw.configure(user: self.homeViewModel.user!)
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 4
    }

}
