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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureViews()
        
    }
    
    private func configureViews() {
        
        self.containerView.backgroundColor = .lighterGray
        
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 11
        
        self.gradientView.clipsToBounds = true
        self.gradientView.layer.cornerRadius = 23
        
        self.gradientView.simpleGradient(colors: graidentColors.randomElement()!)
        
        self.gradientImageView.tintColor = .white
        
        let category = Category.shopping
        
        self.gradientImageView.image = UIImage(named: category.imageName)?.withRenderingMode(.alwaysTemplate)
        
        self.listNameLabel.text = category.name
        self.listNameLabel.textColor = .charcoalBlack
        
    }
    
}