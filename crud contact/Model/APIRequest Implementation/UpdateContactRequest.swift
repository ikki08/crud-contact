//
//  UpdateContactRequest.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import Foundation
import Alamofire

class UpdateContactRequest: APIRequest {
    var contactID: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var age: Int = 0
    var photoURL: String = ""
    
    init(contactID: String, firstName: String, lastName: String, age: Int, photoURL: String) {
        self.contactID = contactID
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.photoURL = photoURL
    }
    
    func parameters() -> [String : Any]? {
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "age" : age,
            "photo" : photoURL
        ]
    }
    
    func endpoint() -> String {
        return "/contact/" + contactID
    }
    
    func method() -> HTTPMethod {
        return .put
    }
}
