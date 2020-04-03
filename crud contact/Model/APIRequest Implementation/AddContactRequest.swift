//
//  AddContactRequest.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import Foundation
import Alamofire

class AddContactRequest: APIRequest {
    var firstName: String = ""
    var lastName: String = ""
    var age: Int = 0
    var photoURL: String = ""
    
    init(firstName: String, lastName: String, age: Int, photoURL: String) {
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
        return "/contact"
    }
    
    func method() -> HTTPMethod {
        return .post
    }
}
