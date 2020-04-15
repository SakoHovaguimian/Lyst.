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

//    var user: User? {
//        didSet {
//            self.configure(user: self.user!)
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Bundle.main.loadNibNamed(TableHeaderView.identifier, owner: self, options: nil)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
//    private func configure(user: User) {
//
//
//
//    }

}
