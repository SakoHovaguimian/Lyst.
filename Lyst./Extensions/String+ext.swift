//
//  String+ext.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/29/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    
    func MD5() -> String {
        
        let email = self
    
        let digest = Insecure.MD5.hash(data: email.lowercased().data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        
    }
    
}
