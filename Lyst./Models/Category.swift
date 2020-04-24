//
//  Category.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import Foundation

enum Category: String, CaseIterable {
    
    case shopping
    case home
    case work
    case misc
    case personal
    case business
    
    var name: String {
        
        switch self {
       
            case .shopping: return "Shopping"
            case .home: return "Home"
            case .work: return "Work"
            case .misc: return "Misc."
            case .personal: return "Personal Growth"
            case .business: return "Business"
            
        }
    }
    
    var imageName: String {
        
        switch self {
       
        case .shopping: return "cart"
        case .home: return "home"
        case .work: return "tools"
        case .misc: return "settings"
        case .personal: return "settings"
        case .business: return "work"
            
        }
    }
    
}
