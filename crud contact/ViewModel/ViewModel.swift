//
//  ViewModel.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewModel: NSObject {
    var contactList: [Contact] = Array()
    var selectedRow = -1
    
    func getContactList(completion:@escaping (_ error: Error?) -> Void) {
        let getContactListRequest = GetContactListRequest()
        let restRequest = RESTRequest()
        restRequest.execute(request: getContactListRequest,
                            success: { response in
                                let jsonResponse = JSON(response)
                                let message = jsonResponse["message"].string!
                                if message == "Get contacts" {
                                    self.parseGetContactList(response: jsonResponse)
                                    completion(nil)
                                } else {
                                    completion(NSError.defaultError)
                                }
        },
                            failure: { error in
                                completion(error)
        })
    }
    
    func parseGetContactList(response: JSON) {
        if let data = response["data"].array, data.count > 0 {
            for contactJSON in data {
                let contact = Contact(json: contactJSON)
                contactList.append(contact)
            }
        }
    }
}

