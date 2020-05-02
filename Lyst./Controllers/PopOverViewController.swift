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
    
    var name: String {
        
        switch self {
            case .uncheck: return "Uncheck All Items"
            case .rename: return "Rename Lyst"
            case .share: return "Share Lyst"
            case .members: return "View Group Members"
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
        
        for i in 0..<Option.numberOfItems {
            
            let option = Option(rawValue: i)
            
            let popOverOptionView = PopOverOptionView(option: option!, tag: i)

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
