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
    
    var list: List?
    
    init(id: String, author: String) {
    
        self.id = id
        self.author = author
        
    }
    
    public func subDict() -> [String : Any] {
        
        return [
            "id": self.id ?? "",
            "author": self.author ?? "",
        ]
        
    }
    
    static func parseSub(json: [String : Any]) -> Subscription {
        
        let author = json["author"] as! String
        let id = json["id"] as! String
        
        return Subscription(id: id, author: author)
        
    }
    
}
