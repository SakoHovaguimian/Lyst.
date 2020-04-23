//
//  ProfileTableHeaderView.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 3/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "TableHeaderView"

    private(set) var user: User?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    public func configure(user: User) {
        
        self.user = user
        
        self.nameLabel.text = "Hi, \(user.firstName)"
        self.nameLabel.textColor = .charcoalBlack
        
        self.listCountLabel.text = "You have \(user.lists.count + user.sharedLists.count) lysts"
        
    }
    
    public func configure(list: List) {

        
        self.nameLabel.text = list.name
        self.nameLabel.textColor = .charcoalBlack
        
        let itemCount = list.incompleteItems.count
        
        self.listCountLabel.text = "You have \(itemCount) items"
        
    }

}
