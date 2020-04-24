//
//  Item.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/21/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class Item {
    
    var id: String = ""
    var ownerId: String = ""
    
    var name: String = ""
    var link: String?
    var image: UIImage?
    
    var isCompleted: Bool = false
    var dateCompleted: String = ""
    
    var linkURL: URL {
        return URL(string: self.link ?? "")!
    }
    
    
}
