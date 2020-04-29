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
        
        self.viewWithTag(100)?.removeFromSuperview()
        self.viewWithTag(101)?.removeFromSuperview()
        
        if item.content == .all {
            
            self.createImageView()
            self.createLinkButton()
            
            return
            
        }
        
        if item.content == .photo {
            
            self.createImageView()
            return
            
        }
        
        if item.content == .link {
            
            self.createLinkButton()
            
            return
            
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
    
    private func createImageView() {
        
        let btn = UIButton(type: .custom)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 11
        btn.tag = 100
        btn.tintColor = .charcoalBlack
        btn.addTarget(self,
                      action: #selector(self.handleImageButtonTapped(_:)),
                      for: .touchUpInside)
        
        let imageURL = URL(string: self.item.imageURL!)
        let placeholder = UIImage(named: "loading")?.withRenderingMode(.alwaysTemplate)
        
        btn.kf.setImage(with: imageURL,
                        for: .normal,
                        placeholder: placeholder)
        
        self.containerView.addSubview(btn)
        
        btn.anchor(top: self.containerView.topAnchor,
                   bottom: self.containerView.bottomAnchor,
                   right: self.containerView.rightAnchor,
                   paddingTop: 8,
                   paddingLeft: 8,
                   paddingBottom: 8,
                   paddingRight: 8,
                   width: (self.containerView.frame.width / 4))
        
    }
    
    private func createLinkButton() {
        
        let btn = UIButton(type: .custom)
        btn.clipsToBounds = true
        btn.tag = 101
        btn.setImage(UIImage(named: "safari"), for: .normal)
        btn.addTarget(self,
                      action: #selector(self.handleLinkButtonTapped(_:)),
                      for: .touchUpInside)
        
        self.containerView.addSubview(btn)
        
        if self.item.content == .link {
            
            btn.anchor(right: self.containerView.rightAnchor,
                       paddingRight: 16,
                       width: 64,
                       height: 64)
            
            btn.centerY(inView: self.containerView)
            
        }
        
        if self.item.content == .all {
            
            btn.anchor(left: self.containerView.leftAnchor,
                       bottom: self.containerView.bottomAnchor,
                       paddingLeft: 32,
                       paddingBottom: 8,
                       width: 32,
                       height: 32)
            
        }
        
    }
    
    @objc private func handleLinkButtonTapped(_ sender: UIButton) {
        self.itemDelegate.didTapLink(self.item)
    }
    
    @objc private func handleImageButtonTapped(_ sender: UIButton) {
        self.itemDelegate.didTapImage(self.item)
    }
    
    
}
