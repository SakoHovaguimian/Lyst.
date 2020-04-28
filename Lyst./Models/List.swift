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
            .sorted(by: { $0.id > $1.id })
    }
    
    public var incompleteItems: [Item] {
        return self.items.filter({ $0.isCompleted == false })
            .sorted(by: { $0.id > $1.id })
    }
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
    }
    
    public func removeItem(_ item: Item) {
        self.items = self.items.filter({ $0.id != item.id })
    }
    
    public func listDict() -> [String : Any] {
        
        let dict: [String : Any] = [
            
            "id": self.id,
            "name" : self.name,
            "author" : self.author,
            "category": self.category.rawValue,
            "items": self.listItemDict()
        ]
        
        return dict
        
    }
    
    public func listItemDict() -> [String : Any] {
        
        var itemDict: [String : Any] = [:]
        
        for item in items {
            itemDict.updateValue(item.itemDict(), forKey: item.id)
        }
        
        return itemDict
        
    }
    
    static func parseList(json: [String : Any]) -> List {
        
        let list = List(name: "", category: .home)
        
        list.id = json["id"] as! String
        list.name = json["name"] as! String
        list.author = list.id
        
        let category = json["category"] as! String
        list.category = Category(rawValue: category) ?? .home
        
        var items = [Item]()
        
        if let jsonItems = json["items"] as? [String : Any] {
            
            for dict in jsonItems {
                
                if let itemDict = dict.value as? [String : Any] {
                    
                    let item = Item.parseItem(json: itemDict)
                    items.append(item)
                    
                }
                
            }
            
            list.items = items
            
        }
        
        
        return list
        
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

