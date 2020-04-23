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
    
}
