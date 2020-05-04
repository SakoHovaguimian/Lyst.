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
        list.author = json["author"] as! String
        
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
        
        list.name = list.name.capitalized
        
        
        return list
        
    }
    
    public func authorUID() -> String {
        
        guard let currentUser = currentUser else { return self.author }
        let uid = currentUser.email?.MD5() ?? ""
        
        return self.author == currentUser.uid ? uid : self.author
        
    }
    
    public func isAuthor() -> Bool {
        
        guard let currentUser = currentUser else { return false }
        let uid = currentUser.email?.MD5() ?? ""
        
        return self.author == uid ? true : false
        
    }
    
}

