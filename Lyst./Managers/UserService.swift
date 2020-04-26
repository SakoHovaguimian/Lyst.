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

class UserService {
    
    static public func createUser(email: String, password: String, fullNmae: String, completion: @escaping(User?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            guard error == nil else { completion(nil); return }
            
            let id = result?.user.uid

            let user = User(name: fullNmae, email: email)
            user.id = id ?? ""
            
            self.updateUser(user) { (_) in
                completion(user)
            }
            
        }
        
    }
    
    static private func updateUser(_ user: User, completion: @escaping (String) -> ()) {
        
        let dbRef = userRef.child(user.id)
        
        dbRef.updateChildValues(user.userDict()) { (error, ref) in
            
            completion("Updated User")
            
        }
        
    }
    
    static func login(email: String, password: String, completion: @escaping (User?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let _ = error {
                completion(nil)
            }
            
            guard let uid = result?.user.uid else { completion(nil); return }
            
            self.fetchUser(uid: uid) { (user) in
                
                completion(user)
                
            }
            
        }
        
    }
    
    static func fetchUser(uid: String, completion: @escaping(User) -> ()) {
        
        let dbRef = userRef.child(uid)
        
        dbRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if let dict = snapshot.value as? [String : Any] {
                
                let user = User.parseUser(json: dict)
                
                completion(user)
                
            }
            
        }
        
    }
    
    static func logout() {
        
        try! Auth.auth().signOut() 
        
    }
    
    
}
