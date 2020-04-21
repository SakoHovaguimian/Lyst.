//
//  CompletionTableHeaderView.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/20/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class CompletionTableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CompletionTableHeaderView"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(text: String) {
        
        self.nameLabel.text = text
        self.nameLabel.textColor = .charcoalBlack
        
    }

}
