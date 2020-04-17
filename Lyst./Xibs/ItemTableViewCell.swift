//
//  ItemTableViewCell.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/17/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    var isFirstCell: Bool = false {
        didSet {
            self.configureViews()
        }
    }
    
    var isLastCell: Bool = false {
        didSet {
            self.configureViews()
        }
    }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCheckBoxButton()
    }
    
    private func configureViews() {
        
        self.containerView.backgroundColor = .lighterGray
        
        let radius: CGFloat = self.isFirstCell || self.isLastCell ? 11 : 0
        let corners = self.cornersToRound()
        self.containerView.roundCorners(corners, radius: radius)
        
        
    }
    
    private func cornersToRound() ->  UIRectCorner {
        
        
        var corner: UIRectCorner = []
        
        if self.isFirstCell {
            corner = [.topLeft, .topRight]
        } else if self.isLastCell {
            corner = [.bottomLeft, .bottomRight]
        }
        
        return corner
        
        
    }
    
    private func configureCheckBoxButton() {
        
        self.checkBoxButton.addTarget(self, action: #selector(self.toggleCheckboxSelection), for: .touchUpInside)
        
        self.checkBoxButton.addShadow(shadow: .black, opacity: 0.5, offSet: .zero, raidus: 1.0)
        
    }
    
    @objc private func toggleCheckboxSelection() {
        self.checkBoxButton.isSelected = !self.checkBoxButton.isSelected
        let isSelected = self.checkBoxButton.isSelected
        self.checkBoxButton.backgroundColor = isSelected ? .lightSalmon : .white
    }
    
    
}
