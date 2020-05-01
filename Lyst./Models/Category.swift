//
//  Category.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

enum Category: String, CaseIterable {
    
    case groceries
    case shopping
    case home
    case gym
    case work
    case music
    case restaurant
    case personal
    case business
    case misc
    
    var name: String {
        
        switch self {
            
            case .groceries: return "Groceries"
            case .shopping: return "Shopping"
            case .home: return "Home"
            case .gym: return "Gym/Fitness"
            case .work: return "Work"
            case .music: return "Music"
            case .restaurant: return "Restaurants"
            case .personal: return "Personal Growth"
            case .business: return "Business"
            case .misc: return "Misc."
            
        }
    }
    
    var imageName: String {
        
        switch self {
            
            case.groceries: return "cart"
            case .shopping: return "shopping"
            case .home: return "home"
            case .gym: return "fitness"
            case .work: return "tools"
            case .music: return "music"
            case .restaurant: return "food"
            case .personal: return "settings"
            case .business: return "work"
            case .misc: return "settings"
            
        }
    }
    
    var gradient: [UIColor] {
        
        switch self {
            
            case .groceries: return [UIColor.mintBlue1!, UIColor.mintBlue2!]
            case .shopping: return [UIColor.royalBlue1!, UIColor.royalBlue2!]
            case .home: return [UIColor.teal1!, UIColor.teal2!]
            case .gym: return [UIColor.bloodRed1!, UIColor.bloodRed2!]
            case .work: return [UIColor.orange1!, UIColor.orange2!]
            case .music: return [UIColor.ash1!, UIColor.ash2!]
            case .restaurant: return [UIColor.magenta1!, UIColor.magenta2!]
            case .personal: return [UIColor.pink1!, UIColor.pink2!]
            case .business: return [UIColor.green1!, UIColor.green2!]
            case .misc: return [UIColor.whitePink1!, UIColor.whitePink2!]
            
        }
        
    }
    
}
