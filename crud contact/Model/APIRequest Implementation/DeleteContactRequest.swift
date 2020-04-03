//
//  DeleteContactRequest.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import Foundation
import Alamofire

class DeleteContactRequest: APIRequest {
    var contactID: String = ""
    
    init(contactID: String) {
        self.contactID = contactID
    }
    
    func endpoint() -> String {
        return "/contact/" + contactID
    }
    
    func method() -> HTTPMethod {
        return .delete
    }
}
