//
//  ItemTableViewCell.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/17/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol DidFinishItemDelegate: class {
    func didFinishItem(_ item: Item)
}

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    weak var itemDelegate: DidFinishItemDelegate!
    
    private var item: Item!
    
    var isFirstCell: Bool = false
    var isLastCell: Bool = false

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCheckBoxButton()
    }
    
    public func configureViews(item: Item, isFirstCell: Bool, isLastCell: Bool) {
        
        self.item = item
        self.isFirstCell = isFirstCell
        self.isLastCell = isLastCell
        
        self.containerView.backgroundColor = .lighterGray
        
        let radius: CGFloat = self.isFirstCell || self.isLastCell ? 11 : 0
        let corners = self.cornersToRound()
        self.containerView.roundCorners(corners, radius: radius)
        self.addShadows()
        
        self.itemNameLabel.text = self.item.name
        
        
    }
    
    private func cornersToRound() ->  UIRectCorner {
        
        
        var corner: UIRectCorner = []
        
        if self.isFirstCell && self.isLastCell {
            corner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
            return corner
        }
        
        if self.isFirstCell {
            corner = [.topLeft, .topRight]
        } else if self.isLastCell {
            corner = [.bottomLeft, .bottomRight]
        }
        
        return corner
        
        
    }
    
    private func addShadows() {
        
        if self.isFirstCell || self.isLastCell {
            self.contentView.addShadow(shadow: .black, opacity: 0.3, offSet: .zero, raidus: 1.0)
        }
        
    }
    
    private func configureCheckBoxButton() {
        
        self.checkBoxButton.addTarget(self, action: #selector(self.toggleCheckboxSelection), for: .touchUpInside)
        
        self.checkBoxButton.addShadow(shadow: .black, opacity: 0.5, offSet: .zero, raidus: 1.0)
        
    }
    
    @objc private func toggleCheckboxSelection() {
        self.checkBoxButton.isSelected = !self.checkBoxButton.isSelected
        let isSelected = self.checkBoxButton.isSelected
        self.checkBoxButton.backgroundColor = isSelected ? .lightSalmon : .white
        self.itemDelegate.didFinishItem(self.item)
    }
    
    
}
