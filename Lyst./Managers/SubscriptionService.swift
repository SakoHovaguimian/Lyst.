//
//  SubscriptionService.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/29/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Firebase

let subRef = Database.database().reference(withPath: "Subscriptions")


class SubscriptionService {
    
    static func addSubscriber(list: List, email: String, completion: @escaping (String) -> ()) {
        
        guard currentUser != nil else { return }
        
        let id = subRef.childByAutoId().key ?? ""
        
        let subsrciption = Subscription(id: id,
                                        author: currentUser?.email?.MD5() ?? "",
                                        to: email.MD5(),
                                        from:  currentUser?.email?.MD5() ?? "",
                                        listId: list.id)

        let values: [String : Any] = subsrciption.subDict()
        
        subRef.child(id).updateChildValues(values) { (error, dbRef) in
            completion("")
        }
        
    }
    
    static func fetchSubscribers(completion: @escaping ([Subscription]) -> ()) {
        
        var subscriptions = [Subscription]()
        
        guard currentUser != nil else { return }
        
        subRef.observe(.value) { snapshot in
            
            snapshot.children.forEach { snap in
                
                let subSnap = snap as? DataSnapshot
                
                if let dict = subSnap?.value as? [String : Any] {
                    
                    let email = currentUser?.email?.MD5() ?? ""
                    let subscription = Subscription.parseSub(json: dict)
                    
                    if subscription.to == email {
                        subscriptions.append(subscription)
                    }
                    
                }
                
            }
            
            completion(subscriptions)
            subscriptions.removeAll()
            
        }
        
    }
    
    //Leave Sharing List
    static func removeSubscription(subscription: Subscription, email: String, completion: @escaping (String) -> ()) {
        subRef.child(subscription.id ?? "").removeValue()
    }
    
    //Delete The List
    static func deleteAllSubscriptions(for list: List, completion: @escaping () -> ()) {
        
        subRef.observe(.value) { snapshot in
            
            snapshot.children.forEach { snap in
                
                let subSnap = snap as? DataSnapshot
                
                if let dict = subSnap? .value as? [String : Any] {
                    
                    let subscription = Subscription.parseSub(json: dict)
                    
                    if subscription.listId == list.id {
                        subRef.child(subscription.id!).removeValue()
                    }
                    
                }
                
            }
        }
    }
    
    //Fetch All Users Sharing The Lists
    
}
