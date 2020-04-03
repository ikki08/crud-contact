//
//  Contact.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import UIKit
import SwiftyJSON

class Contact: NSObject {
    var id: String?
    var firstName: String!
    var lastName: String!
    var age: Int!
    var photoURL: String!
    
    init(id: String?, firstName: String, lastName: String, age: Int, photoURL: String) {
        super.init()
        
        if let `id` = id {
            self.id = id
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.photoURL = photoURL
    }
    
    init(json: JSON) {
        super.init()
        
        self.setContactData(json: json)
    }
    
    private func setContactData(json: JSON) {
        id = json["id"].string!
        firstName = json["firstName"].string!
        lastName = json["lastName"].string!
        age = json["age"].int!
        photoURL = json["photo"].string!
    }
}
