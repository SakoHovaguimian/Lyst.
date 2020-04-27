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
let listRef = dbRef.child("Lists")

class LystService {
    
    static func createList(list: List, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let autoId = listRef.childByAutoId().key ?? ""
        
        let id = currentUser.uid
        let ref = listRef.child(id)
        
        let updatedList = list
        updatedList.id = autoId
        updatedList.author = id
        
        let values: [String : Any] = [autoId: updatedList.listDict()]
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
    static func fetchListsForUser(completion: @escaping ([List]?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        var lists: [List] = []

        let id = currentUser.uid
        let ref = listRef.child(id)
        
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
            
            completion(lists)
            
        }
        
    }
    
    static func fetchList(id: String, completion: @escaping (List?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let userId = currentUser.uid
        
        listRef.child(userId).child(id).observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let list = List.parseList(json: dict)
                completion(list)
                
            }
            
        }
        
    }
    
    static func updateList(list: List) {
        
        guard let currentUser = currentUser else { return }
        
        let userId = currentUser.uid
        let values: [String : Any] = list.listItemDict()
        listRef.child(userId).child(list.id).child("items").updateChildValues(values)

    }

    
    static func updateItem(forList list: List, item: Item, shouldRemove: Bool = false, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let id = currentUser.uid
        
        let ref = listRef.child(id).child(list.id).child("items").child(item.id)
        
        if shouldRemove {
            ref.removeValue()
            completion("")
            return
        }
        
        ref.updateChildValues(item.itemDict())
        
        completion("Done")
        
    }
    
    static func createItem(forList list: List, item: Item, completion: @escaping (String?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        let id = currentUser.uid
        
        let itemId = listRef.childByAutoId().key ?? ""
        
        let ref = listRef.child(id).child(list.id).child("items")
        
        let updatedItem = item
        item.id = itemId
        
        let values: [String : Any] = [itemId : updatedItem.itemDict()]
        
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
}
