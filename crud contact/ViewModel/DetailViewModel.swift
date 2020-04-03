//
//  DetailViewModel.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewModel: NSObject {
    var contact: Contact?
    
    override init() {
        super.init()
    }
    
    init(contact: Contact) {
        super.init()

        self.contact = contact
    }
    
    func addNewContact(contact: Contact, completion:@escaping (_ error: Error?) -> Void) {
        let addNewContactRequest = AddContactRequest(firstName: contact.firstName,
                                                     lastName: contact.lastName,
                                                     age: contact.age,
                                                     photoURL: contact.photoURL)
        let restRequest = RESTRequest()
        restRequest.execute(request: addNewContactRequest,
                            success: { response in
                                let jsonResponse = JSON(response)
                                let message = jsonResponse["message"].string!
                                if message == "contact saved" {
                                    completion(nil)
                                } else {
                                    completion(NSError.defaultError)
                                }
        },
                            failure: { error in
                                completion(error)
        })
    }
    
    func updateContact(contact: Contact, completion:@escaping (_ error: Error?) -> Void) {
        guard let contactID = contact.id else {
            completion(NSError.defaultError)
            return
        }
        
        let updateContactRequest = UpdateContactRequest(contactID: contactID,
                                                        firstName: contact.firstName,
                                                        lastName: contact.lastName,
                                                        age: contact.age,
                                                        photoURL: contact.photoURL)
        let restRequest = RESTRequest()
        restRequest.execute(request: updateContactRequest,
                            success: { response in
                                let jsonResponse = JSON(response)
                                let message = jsonResponse["message"].string!
                                if message == "Contact edited" {
                                    completion(nil)
                                } else {
                                    completion(NSError.defaultError)
                                }
        },
                            failure: { error in
                                completion(error)
        })
    }
    
    func deleteContact(completion:@escaping (_ error: Error?) -> Void) {
        guard let `contact` = contact, let contactID = contact.id else {
            completion(NSError.defaultError)
            return
        }
        
        let deleteContactRequest = DeleteContactRequest(contactID: contactID)
        let restRequest = RESTRequest()
        restRequest.execute(request: deleteContactRequest,
                            success: { response in
                                let jsonResponse = JSON(response)
                                let message = jsonResponse["message"].string!
                                if message == "contact deleted" {
                                    completion(nil)
                                } else {
                                    completion(NSError.defaultError)
                                }
        },
                            failure: { error in
                                completion(error)
        })
    }
}
