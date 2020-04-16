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
    
    //MARK:- @OBJC Functions
    
    //MARK:- Helper Functions
    private func configureViews() {
        
        self.view.backgroundColor = .white
        
        self.configureTableView()
        self.configureAlphaView()
        
    }
    
    private func configureTableView() {
        
        self.view.addSubview(self.itemsTableView)
        self.itemsTableView.addConstraintsToFillView(self.view)
        
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
