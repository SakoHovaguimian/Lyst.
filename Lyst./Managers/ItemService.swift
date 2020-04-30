//
//  ItemService.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/27/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Firebase

class ItemService {
    
    static func createItem(forList list: List, item: Item, uid: String, completion: @escaping (Item?) -> ()) {
        
        let itemId = listRef.childByAutoId().key ?? ""
        
        let ref = listRef.child(uid).child(list.id).child("items")
        
        let updatedItem = item
        item.id = itemId
        
        let values: [String : Any] = [itemId : updatedItem.itemDict()]
        
        ref.updateChildValues(values)
        
        completion(item)
        
    }
    
    static func updateItem(forList list: List, item: Item, uid: String, shouldRemove: Bool = false, completion: @escaping (String?) -> ()) {
        
        let ref = listRef.child(uid).child(list.id).child("items").child(item.id)
        
        if shouldRemove {
            ref.removeValue()
            
            ItemService.removeImage(item: item)
            
            completion("")
            return
        }
        
        ref.updateChildValues(item.itemDict())
        
        completion("Done")
        
    }
    
    static func updateAllItemsInList(uid: String, _ list: List) {
  
        let values: [String : Any] = list.listItemDict()
        listRef.child(uid).child(list.id).child("items").updateChildValues(values)
        
    }
    
    static func saveImage(item: Item, image: UIImage, completion: @escaping (String) -> ()) {
        
        let meta = StorageMetadata()
        meta.contentType = "image/jpg"
        
        let imageData = image.jpegData(compressionQuality: 0.1)
        let storageRef = Storage.storage().reference().child(item.id)
        
        storageRef.putData(imageData!, metadata: meta) { (download, error) in
            
            storageRef.downloadURL { (url, error) in
                
                completion(url?.absoluteString ?? "")
                
            }
            
        }
        
    }
    
    static func removeImage(item: Item) {
        
        let storageRef = Storage.storage().reference().child(item.id)
        
        storageRef.delete { (error) in
            
            
        }
        
    }
    
}
