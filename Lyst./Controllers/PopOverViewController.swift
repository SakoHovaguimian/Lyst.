//
//  PopOverViewController.swift
//  ProjectPractice
//
//  Created by Sako Hovaguimian on 4/11/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Animo

enum Option: Int, CaseIterable {
    
    case uncheck
    case rename
    case share
    case members
    case delete
    
    var name: String {
        
        switch self {
            case .uncheck: return "Uncheck All Items"
            case .rename: return "Rename Lyst"
            case .share: return "Share Lyst"
            case .members: return "View Group Members"
            case .delete: return "Delete List"
        }
        
    }
    
    static var numberOfItems: Int {
        return self.allCases.count
    }

}

protocol OptionButtonTappedDelegate: class {
    func handleOptionButtonTapped(forOption option: Option)
}

class PopOverViewController: UIViewController {
    
    private var list: List!
    
    weak var optionsButtonDelegate: OptionButtonTappedDelegate!
    
    private lazy var optionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.generateOptionButtons())
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureViews()
        self.view.backgroundColor = .white
        
    }
    
    init(list: List) {
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.view.addSubview(self.optionsStackView)
        self.optionsStackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                     left: self.view.leftAnchor,
                                     bottom: self.view.bottomAnchor,
                                     right: self.view.rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0)
    }
    
    private func generateOptionButtons() -> [PopOverOptionView] {

        var options = [PopOverOptionView]()
        
        for option in self.list.optionsAvailableForUser() {
            
            let popOverOptionView = PopOverOptionView(option: option,
                                                      isAuthor: self.list.isAuthor())

            popOverOptionView.button.addTarget(self, action: #selector(self.handleButtonTapped(sender:)), for: .touchUpInside)
            
            options.append(popOverOptionView)
            
        }

        
        return options
        
    }
    
    @objc private func handleButtonTapped(sender: UIButton) {
        if let option = Option(rawValue: sender.tag) {
            self.dismiss(animated: true, completion: nil)
            self.optionsButtonDelegate.handleOptionButtonTapped(forOption: option)
        }
    }
    
}
