//
//  SubscriptionService.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/29/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Firebase


class SubscriptionService {
    
    static func addSubscriber(list: List, email: String, completion: @escaping (String) -> ()) {
        
        guard currentUser != nil else { return }
        
        let subsrciption = Subscription(id: list.id,
                                        author: currentUser?.email?.MD5() ?? "")
        
        let values: [String : Any] = [list.id: subsrciption.subDict()]
        
        userRef.child(email.lowercased().MD5()).child("subscriptions").updateChildValues(values) { (error, dbRef) in
            completion("")
        }
        
    }
    
    static func fetchSubsriptions(user: User, completion: @escaping (User) -> ()) {
        
        let updatedUser = user
        
        var allSubs = [Subscription]()
        
        userRef.child(user.email.MD5()).child("subscriptions").observe(.value) { snapshot in
            
            snapshot.children.forEach { snap in
                
                let subSnap = snap as? DataSnapshot
                
                if let dict = subSnap? .value as? [String : Any] {
                    
                    let subscription = Subscription.parseSub(json: dict)
                    
                    LystService.fetchList(uid: subscription.author ?? "", id: subscription.id ?? "") { list in
                        
                        if let _ = user.subscriptions {
                            
                        user.subscriptions?.filter({$0.list?.id == subscription.id}).first?.list = list
                        completion(user)
                            
                        }
                        
                        subscription.list = list
                        allSubs.append(subscription)
                        
                        if allSubs.count == snapshot.childrenCount {
                            print(user.subscriptions?.count)
                            updatedUser.subscriptions = allSubs
                            completion(updatedUser)
                            allSubs.removeAll()
                            return
                        }
                        
                    }

                }
                
            }
    
        }
    
    }



}
