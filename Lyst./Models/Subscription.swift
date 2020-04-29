//
//  Subscription.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/29/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class Subscription {
    
    var id: String?
    var author: String?
    var listId: String?
    
    var list: List?
    
    init(id: String, author: String, listId: String) {
    
        self.id = id
        self.author = author
        self.listId = listId
        
    }
    
}
