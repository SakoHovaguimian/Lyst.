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
    var author: String = ""
    var category: Category = .misc
    var items: [Item] = []
    
    public var completedItems: [Item] {
        return self.items.filter({ $0.isCompleted == true })
    }
    
    public var incompleteItems: [Item] {
        return self.items.filter({ $0.isCompleted == false })
    }
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
    }
    
    public func removeItem(_ item: Item) {
        self.items = self.items.filter({ $0.id != item.id })
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
        item1.id = "1"
        item1.name = "Carrots"
        
        let item2 = Item()
        item1.id = "2"
        item2.name = "Brocolli"
        
        list1.items.append(contentsOf: [item1, item2])
        
        return list1
        
    }
    
}

