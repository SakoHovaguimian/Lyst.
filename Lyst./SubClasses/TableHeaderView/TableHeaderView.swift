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

    private(set) var user: User!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Bundle.main.loadNibNamed(TableHeaderView.identifier, owner: self, options: nil)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    public func configure(user: User) {
        
        self.user = user
        
        self.nameLabel.text = "Hi, \(self.user.firstName)"
        self.nameLabel.textColor = .charcoalBlack
        
        self.listCountLabel.text = "You have 4 lysts"
        
    }

}
