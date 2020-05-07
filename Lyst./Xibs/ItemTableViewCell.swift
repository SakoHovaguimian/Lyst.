//
//  ItemTableViewCell.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/17/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

protocol ItemTableViewCellDelegate: class {
    
    func didFinishItem(_ item: Item)
    func didTapLink(_ item: Item)
    func didTapImage(_ item: Item)
    
}


class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    weak var itemDelegate: ItemTableViewCellDelegate!
    
    private var item: Item!
    
    var isFirstCell: Bool = false
    var isLastCell: Bool = false
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var safariButton: UIButton!
    @IBOutlet weak var imageButton: UIButton!
    
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
        //        self.itemNameLabel.textColor = .charcoalBlack
        
        self.checkBoxButton.backgroundColor =  self.item.isCompleted ? .imgurGreen : .white
        self.checkBoxButton.isSelected = self.item.isCompleted ? true : false

        self.configureContent()
        
    }
    
    private func configureContent() {

        self.imageButton.isHidden = self.item.content == .all || self.item.content == .photo ? false : true
        self.safariButton.isHidden = self.item.content == .all || self.item.content == .link ? false : true
    
        self.imageButton.setImage(UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate),
                                   for: .normal)
        
        if self.item.content == .link {
            self.safariButton.anchor(right: self.containerView.rightAnchor, paddingRight: 16)
        } else {
            self.safariButton.anchor(right: self.imageButton.leftAnchor, paddingRight: 10)
        }
    
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
        
        self.contentView.addShadow(shadow: .black, opacity: 0.3, offSet: .zero, raidus: 0.5)
    }
    
    private func configureCheckBoxButton() {
        
        self.checkBoxButton.addTarget(self, action: #selector(self.toggleCheckboxSelection), for: .touchUpInside)
        
        self.checkBoxButton.addShadow(shadow: .black, opacity: 0.5, offSet: .zero, raidus: 1.0)
        
    }
    
    @objc private func toggleCheckboxSelection() {
        self.itemDelegate.didFinishItem(self.item)
    }
    
    @objc private func handleLinkButtonTapped(_ sender: UIButton) {
        self.itemDelegate.didTapLink(self.item)
    }
    
    @objc private func handleImageButtonTapped(_ sender: UIButton) {
        self.itemDelegate.didTapImage(self.item)
    }
    
    
}
