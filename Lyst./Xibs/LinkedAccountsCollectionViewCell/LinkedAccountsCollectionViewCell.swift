//
//  SettingsCategoryCollectionViewCell.swift
//  Dank Memes Direct
//
//  Created by Sako Hovaguimian on 8/23/19.
//  Copyright © 2019 Sako Hovaguimian. All rights reserved.
//

import UIKit

class LinkedAccountsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var name: String? {
        didSet {
            self.configure()
        }
    }
    
    static let identifier = "LinkedAccountsCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configure() {
        
        self.backgroundColor = .lighterGray
        
        self.label.textColor = .charcoalBlack
        self.label.font = UIFont(name: avenirNextBold, size: 15.0)
        self.label.text = name
        
        self.layer.cornerRadius = 17.5
        self.addShadow(shadow: .black, opacity: 0.3, offSet: .zero, raidus: 1.0)
    }

}
