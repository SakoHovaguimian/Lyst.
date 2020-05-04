//
//  ItemsViewController.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/16/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class ItemsViewController: UIViewController {
    
    //MARK:- Properties
    
    private var itemsViewModel: ItemsViewModel!
    
    private var popOverViewController: PopOverViewController?
    
    //MARK:- Views
    private(set) lazy var itemsTableView: UITableView = {
        return self.setupTableView()
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
    
    private lazy var optionsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("...", for: .normal)
        btn.setTitleColor(.charcoalBlack, for: .normal)
        btn.titleLabel?.font = UIFont(name: avenirNextBold, size: 25.0)
        btn.addTarget(self,
                      action: #selector(self.optionsButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    private lazy var floatingAddButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .charcoalBlack
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "add"), for: .normal)
        btn.addTarget(self,
                      action: #selector(self.addButtonTapped(_:)),
                      for: .touchUpInside)
        return btn
    }()
    
    //MARK:- Life Cycle
    
    init(viewModel: ItemsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.itemsViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchList()
        self.configureViews()
        
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.view.backgroundColor = .white
        
        self.configureTableView()
        self.configureAlphaView()
        self.configureButtons()
        
    }
    
    private func configureTableView() {
        
        self.view.addSubview(self.itemsTableView)
        self.itemsTableView.addConstraintsToFillView(self.view)
        
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
    
    private func configureButtons() {
        
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
        
        //Add Button
        self.view.addSubview(self.optionsButton)
        
        self.optionsButton.centerY(inView: backImageView, constant: 3)
        self.optionsButton.anchor(right: self.view.rightAnchor,
                                  paddingRight: 16,
                                  width: 32,
                                  height: 32)
        
        //Floating Add Button
        self.view.addSubview(self.floatingAddButton)
        
        self.floatingAddButton.setDimmensions(height: 75, width: 75)
        self.floatingAddButton.centerX(inView: self.view)
        self.floatingAddButton.anchor(bottom: self.view.bottomAnchor, paddingBottom: 32)
        self.floatingAddButton.layer.cornerRadius = 35.5
        self.floatingAddButton.addShadow(shadow: .black, opacity: 0.8, offSet: .zero, raidus: 1.0)
        
    }
    
    private func setupTableView() -> UITableView {
        
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        tv.contentInsetAdjustmentBehavior = .never
        tv.register(UINib(nibName: ItemTableViewCell.identifier,
                          bundle: nil),
                    forCellReuseIdentifier: ItemTableViewCell.identifier)
        tv.register(UINib(nibName: TableHeaderView.identifier,
                          bundle: nil),
                    forHeaderFooterViewReuseIdentifier: TableHeaderView.identifier)
        tv.register(UINib(nibName: CompletionTableHeaderView.identifier,
                          bundle: nil),
                    forHeaderFooterViewReuseIdentifier: CompletionTableHeaderView.identifier)
        
        return tv
        
    }
    
    private func fetchList() {
        
        self.shouldPresentLoadingView(true)
        
        self.itemsViewModel.fetchList {
            
            self.itemsTableView.reloadData()
            self.shouldPresentLoadingView(false)
            
        }
        
    }
    
    private func updateList() {
        self.itemsViewModel.uncheckAllItems()
    }
    
    private func loadPopOverViewController() {
        
        let isAuthor = self.itemsViewModel.list.isAuthor()
        self.popOverViewController = PopOverViewController(isAuthor: isAuthor)

        self.popOverViewController?.modalPresentationStyle = .popover
        self.popOverViewController?.optionsButtonDelegate = self

        let popOverVC = self.popOverViewController?.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.optionsButton
        popOverVC?.popoverBackgroundViewClass = nil
        
        self.view.alpha = 0.7
        
        self.popOverViewController?.preferredContentSize = CGSize(width: 250, height: 200)

        self.present(self.popOverViewController!, animated: true)
        
    }
    
    
    //MARK:- @OBJC Functions
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.itemsViewModel.handleBackButtonTapped(sender)
    }
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        self.itemsViewModel.handleAddButtonTapped(sender)
        self.itemsTableView.reloadData()
    }
    
    @objc private func optionsButtonTapped(_ sender: UIButton) {
//        self.itemsViewModel.handleOptionsButtonTapped(sender)
        self.loadPopOverViewController()
    }
    
}

//MARK:- Extensions

//MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsViewModel.numberOfItemsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.itemsViewModel.configureCellForRowAt(indexPath: indexPath, tableView: self.itemsTableView)
        cell?.itemDelegate = self
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.itemsViewModel.tableViewSectionHeaderFor(section: section, tableView: self.itemsTableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.itemsViewModel.heightForRowAt(indexPath: indexPath,
                                                  height: self.view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 50 }
        return self.view.frame.height / 4.2
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            print("DELETED ITEM")
            self.itemsViewModel.removeItemAt(indexPath: indexPath)
            self.itemsTableView.reloadData()
            completion(true)
        }
        
        if let cgImage =  UIImage(named: "delete_trash")?.cgImage {
            action.image = ImageWithoutRender(cgImage: cgImage, scale: UIScreen.main.nativeScale, orientation: .up)
        }
        action.backgroundColor = UIColor.init(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

//MARK:- ITEM UPDATE DELEGATE DidFinishItemDelegate
extension ItemsViewController: ItemTableViewCellDelegate {
    
    func didTapLink(_ item: Item) {
        self.itemsViewModel.handleLinkButtonTapped(item: item)
    }
    
    func didTapImage(_ item: Item) {
        self.itemsViewModel.handleImageButtonTapped(item: item)
    }
    
    
    func didFinishItem(_ item: Item) {
        self.itemsViewModel.updateItemFinishedState(item)
        self.itemsTableView.reloadData()
    }
    
}

extension ItemsViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.view.alpha = 1.0
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        self.popOverViewController = nil
    }
    
}

extension ItemsViewController: OptionButtonTappedDelegate {
    
    func handleOptionButtonTapped(forOption option: Option) {
        self.view.alpha = 1.0
        self.itemsViewModel.handleSelectedOption(option)
        logSuccess(option.name)
    }
    
}
