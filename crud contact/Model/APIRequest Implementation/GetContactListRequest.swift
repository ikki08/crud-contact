//
//  GetContactListRequest.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import Foundation
import Alamofire

class GetContactListRequest: APIRequest {
    func endpoint() -> String {
        return "/contact"
    }
    
    func method() -> HTTPMethod {
        return .get
    }
}
