//
//  UserService.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/25/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Firebase

let dbRef = Database.database().reference()
let lystRef = dbRef.child("Lists")

class LystService {
    
    static func uploadLyst(list: List, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let autoId = lystRef.childByAutoId().key ?? ""
        
        let id = currentUser.uid
        let ref = lystRef.child(id)
        
        let updatedList = list
        updatedList.id = autoId
        
        let values: [String : Any] = [autoId: updatedList.listDict()]
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
    static func fetchLystsForUser(completion: @escaping ([List]?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        var lists: [List] = []

        let id = currentUser.uid
        let ref = lystRef.child(id)
        
        ref.observe(.value) { (snapshot) in
            
            lists.removeAll()
            
            snapshot.children.forEach { snap in
                
                let listSnap = snap as? DataSnapshot
                
                if let dict = listSnap?.value as? [String : Any] {
                    
                    let list = List.parseList(json: dict)
                    lists.append(list)
                    
                    completion(lists)
                    
                }
                
            }
            
        }
        
    }
    
    static func fetchLyst(id: String, completion: @escaping (List?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let id = currentUser.uid
        
        lystRef.child(id).child(id).observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let list = List.parseList(json: dict)
                completion(list)
                
            }
            
        }
        
    }
    
    static func updateItem(forList list: List, item: Item, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let id = currentUser.uid
        
        let itemId = lystRef.childByAutoId().key ?? ""
        
        let ref = lystRef.child(id).child(list.id).child("items")
        
        let updatedItem = item
        item.id = itemId
        item.name = "Digimon was before Pokemon"
        item.isCompleted = true
        
        let values: [String : Any] = [itemId : updatedItem.itemDict()]
        
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
    static func createItem(forList list: List, item: Item, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let id = currentUser.uid
        
        let itemId = lystRef.childByAutoId().key ?? ""
        
        let ref = lystRef.child(id).child(list.id).child("items")
        
        let updatedItem = item
        item.id = itemId
        item.name = "Naruto was before Pokemon"
        item.isCompleted = true
        
        let values: [String : Any] = [itemId : updatedItem.itemDict()]
        
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
}
