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
    
    //MARK:- Views
    private lazy var itemsTableView: UITableView = {
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
        
        self.configureViews()
        
    }
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.view.backgroundColor = .white
        
        self.configureTableView()
        self.configureAlphaView()
        self.configureBackButtonView()
        
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
    
    
    //MARK:- @OBJC Functions
    @objc private func backButtonTapped(_ sender: UIButton) {
        self.itemsViewModel.handleBackButtonTapped(sender)
    }
    
}

    //MARK:- Extensions

    //MARK:- TABLE VIEW DELEGATE & DATASOURCE
extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.itemsTableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell {
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = self.itemsTableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.identifier) as! TableHeaderView
        vw.configure(list: self.itemsViewModel.list)
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 8.5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 4
    }

}
