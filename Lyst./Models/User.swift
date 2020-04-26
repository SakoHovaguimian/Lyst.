//
//  User.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/15/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import Foundation

class User {
    
    var id: String = ""
    var name: String
    var email: String
    var lists: [List] = List.generateList()
    var sharedLists: [List] = List.generateList().reversed()
    
    var firstName: String {
        return self.fetchFirstName()
    }
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    //Create Another init for JSON Parsing
    
    private func fetchFirstName() -> String {
        let name = self.name.split(separator: " ")
        if name.count > 0 {
            return String(name[0])
        }
        
        return self.name
    }
    
    public func userDict() -> [String : Any] {
        
        let dict: [String : Any] = [
            "id": id,
            "name": name,
            "email": email
        ]
        
        return dict
        
    }
    
    static public func parseUser(json: [String : Any]) -> User {
        
        let id = json["id"] as! String
        let name = json["name"] as! String
        let email = json["email"] as! String

        let user = User(name: name, email: email)
        user.id = id
        
        return user
        
    }
    
}
