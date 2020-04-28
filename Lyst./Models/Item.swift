//
//  Item.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/21/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

enum Content: Int {
    
    case text
    case link
    case photo
    case all
    
}

class Item {
    
    var id: String = ""
    var ownerId: String = ""
    
    var name: String = ""
    var link: String?
    var imageURL: String?
    
    var isCompleted: Bool = false
    var dateCompleted: String = ""
    
    var content: Content {
        return self.typeOfContent()
    }
    
    private func typeOfContent() -> Content {
        
        var content = Content.text
        
        if let _ = self.link {
            content = .link
        }
        
        if let _ = self.imageURL {
            content = .photo
        }
        
        if let _ = self.link, let _ = self.imageURL {
            content = .all
        }
        
        return content
        
    }
    
    public func itemDict() -> [String : Any] {
        
        var dict: [String : Any] = [
            "id" : self.id,
            "name" : self.name,
            "isCompleted" : self.isCompleted,
            "dateCompleted" : self.dateCompleted,
        ]
        
        if let link = self.link {
            dict.updateValue(link, forKey: "link")
        }
        
        if let imageURL = self.imageURL {
            dict.updateValue(imageURL, forKey: "imageURL")
        }
        
        return dict
        
    }
    
    static func parseItem(json: [String : Any]) -> Item {
        
        let item = Item()
        
        item.id = json["id"] as! String
        item.name = json["name"] as! String
        item.isCompleted = json["isCompleted"] as! Bool
        item.dateCompleted = json["dateCompleted"] as! String
        
        if let link = json["link"] as? String {
            item.link = link
        }
        
        if let imageURL = json["imageURL"] as? String {
            item.imageURL = imageURL
        }
        
        return item
        
    }
    
    
}
