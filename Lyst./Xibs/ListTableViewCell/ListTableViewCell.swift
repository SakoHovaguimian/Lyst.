//
//  ListTableViewCell.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"
    
    private(set) var list: List!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public func configureList(list: List) {
        self.list = list
        self.configureViews()
    }
    
    private func configureViews() {
        
        self.containerView.backgroundColor = .lighterGray
        
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 11
        
        self.containerView.addShadow(shadow: .black, opacity: 0.3, offSet: .zero, raidus: 1.0)
        
        self.gradientView.clipsToBounds = true
        self.gradientView.layer.cornerRadius = 23
        
        self.gradientView.simpleGradient(colors: graidentColors.randomElement()!)
        
        self.gradientImageView.tintColor = .white
        
        let category = list.category
        
        self.gradientImageView.image = UIImage(named: category.imageName)?.withRenderingMode(.alwaysTemplate)
        
        self.listNameLabel.text = list.name
        self.listNameLabel.textColor = .charcoalBlack
        
        
    }
    
}
