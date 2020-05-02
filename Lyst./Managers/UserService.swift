//
//  UserService.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/26/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

let userRef = Database.database().reference().child("User")
var currentUser = Auth.auth().currentUser

class UserService {
    
    static public func createUser(email: String, password: String, fullNmae: String, completion: @escaping(User?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            guard error == nil else { completion(nil); return }
            
            let id = result?.user.uid
            
            currentUser = result?.user
            
            let user = User(name: fullNmae, email: email)
            user.id = id ?? ""
            
            self.updateUser(user) { (_) in
                
                self.login(email: email, password: password) { (user) in
                    
                    completion(user)
                    
                }
                
            }
            
        }
        
    }
    
    
    static func fetchUser(email: String, completion: @escaping(User?) -> ()) {
        
        let dbRef = userRef.child(email.MD5())
        
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let user = User.parseUser(json: dict)
                
                completion(user)
                
            } else {
                
                completion(nil)
                
            }
            
        }
        
    }
    
    static func observeUser(email: String, completion: @escaping(User?) -> ()) {
        
        let dbRef = userRef.child(email.MD5())
        
        dbRef.observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let user = User.parseUser(json: dict)
                
                completion(user)
                
            } else {
                
                completion(nil)
                
            }
            
        }
        
    }
    
    static private func updateUser(_ user: User, completion: @escaping (String) -> ()) {
        
        let dbRef = userRef.child(user.email.MD5())
        
        dbRef.updateChildValues(user.userDict()) { (error, ref) in
            
            completion("Updated User")
            
        }
        
    }
    
    static func login(email: String, password: String, completion: @escaping (User?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let _ = error {
                completion(nil)
            }
            
            currentUser = result?.user
            
            guard let email = result?.user.email else { completion(nil); return }
            
            self.fetchUser(email: email) { (user) in
                
                completion(user)
                
            }
            
        }
        
    }
    
    static func logout() {
        
        try! Auth.auth().signOut() 
        
    }
    
    
}
