//
//  List.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/17/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class List {
    
    var id: String = ""
    var name: String = ""
    var category: Category = .misc
    var items: [Item] = []
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
    }
    
    static func generateList() -> [List] {
        
        return [
            self.createListsWithItems(),
            List(name: "Shopping List", category: .business),
            List(name: "Grocery List", category: .misc),
            List(name: "Movies List", category: .shopping),
            List(name: "Anime List", category: .business)
        ]
        
    }
    
    static func createListsWithItems() -> List{
        
        let list1 = List(name: "Items Test List", category: .business)
        
        let item1 = Item()
        item1.name = "Carrots"
        
        let item2 = Item()
        item2.name = "Brocolli"
        
        list1.items.append(contentsOf: [item1, item2])
        
        return list1
        
    }
    
}

class Item {
    
    var id: String = ""
    var ownerId: String = ""
    
    var name: String = ""
    var completed: Bool = false
    var dateCompleted: String = ""
    
    var imageURL: String = ""
    
}

