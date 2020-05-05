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
    var to = ""
    var from = ""
    var listId = ""
    
    var list: List?
    
    init(id: String, author: String, to: String, from: String, listId: String) {
    
        self.id = id
        self.author = author
        self.to = to
        self.from = from
        self.listId = listId
        
    }
    
    public func subDict() -> [String : Any] {
        
        return [
            "id": self.id ?? "",
            "author": self.author ?? "",
            "to": self.to,
            "from": self.from,
            "listId": self.listId
        ]
        
    }
    
    static func parseSub(json: [String : Any]) -> Subscription {
        
        let author = json["author"] as! String
        let id = json["id"] as! String
        let to = json["to"] as! String
        let from = json["from"] as! String
        let listId = json["listId"] as! String
        
        let subscription = Subscription(id: id,
                                        author: author,
                                        to: to,
                                        from: from,
                                        listId: listId)

        
        return subscription
        
    }
    
}
