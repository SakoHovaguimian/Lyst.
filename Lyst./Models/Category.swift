//
//  Category.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

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
    
    var gradient: [UIColor] {
        
         switch self {
        
         case .shopping: return [UIColor.royalBlue1!, UIColor.royalBlue2!]
         case .home: return [UIColor.teal1!, UIColor.teal2!]
         case .work: return [UIColor.orange1!, UIColor.orange2!]
         case .misc: return [UIColor.whitePink1!, UIColor.whitePink2!]
         case .personal: return [UIColor.pink1!, UIColor.pink2!]
         case .business: return [UIColor.green1!, UIColor.green2!]
             
         }
        
    }
    
}
