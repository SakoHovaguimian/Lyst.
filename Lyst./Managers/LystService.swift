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
        
        let id = currentUser.email?.MD5() ?? ""
        let ref = listRef.child(id)
        
        let updatedList = list
        updatedList.id = autoId
        
        let values: [String : Any] = [autoId: updatedList.listDict()]
        ref.updateChildValues(values)
        
        completion("Done")
        
    }
    
    static func fetchListsForUser(completion: @escaping ([List]?) -> ()) {
        
        guard let currentUser = currentUser else {completion(nil); return }
        
        var lists: [List] = []
        
        let id = currentUser.email?.MD5() ?? ""
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
        
        let userId = currentUser.email?.MD5() ?? ""
        
        listRef.child(userId).child(id).observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let list = List.parseList(json: dict)
                completion(list)
                
            }
            
        }
        
    }
    
    static func updateList(_ list: List) {
        
        guard let currentUser = currentUser else { return }
        
        let userId = currentUser.email?.MD5() ?? ""
        let values: [String : Any] = list.listDict()
        listRef.child(userId).child(list.id).updateChildValues(values)
        
    }
    
    
}
