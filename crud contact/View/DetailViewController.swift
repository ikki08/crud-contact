//
//  DetailViewController.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func addUpdateDeleteSucceed()
}

class DetailViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var photoURLTextField: UITextField!
    @IBOutlet weak var loadingView: LoadingView!
    
    var viewModel: DetailViewModel!
    weak var delegate: DetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextField()
    }
    
    //MARK: - Action
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        loadingView.show()
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let age = ageTextField.text,
            let photoURL = photoURLTextField.text else {
                return
        }
        
        var contactID: String? = nil
        if let contact = viewModel.contact, let aContactID = contact.id {
            contactID = aContactID
        }
        
        var photo = "N/A"
        if photoURL.count > 0 {
            photo = photoURL
        }
        
        let newContact = Contact(id: contactID,
                                 firstName: firstName,
                                 lastName: lastName,
                                 age: Int(age) ?? 0,
                                 photoURL: photo)
        
        if contactID == nil {
            addNewContact(contact: newContact)
        } else {
            updateContact(contact: newContact)
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        loadingView.show()
        deleteContact()
    }
    
    //MARK: Private function
    
    private func setupTextField() {
        guard let contact = viewModel.contact else { return }
        
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        ageTextField.text = String(contact.age)
        if contact.photoURL != "N/A" {
            photoURLTextField.text = contact.photoURL
        }
    }
    
    private func addNewContact(contact: Contact) {
        viewModel.addNewContact(contact: contact) { error in
            self.handleFinishedRequest(with: error)
        }
    }
    
    private func updateContact(contact: Contact) {
        viewModel.updateContact(contact: contact) { error in
            self.handleFinishedRequest(with: error)
        }
    }
    
    private func deleteContact() {
        viewModel.deleteContact() { error in
            self.handleFinishedRequest(with: error)
        }
    }
    
    private func handleFinishedRequest(with error: Error?) {
        loadingView.hide()
        if error == nil {
            delegate?.addUpdateDeleteSucceed()
        } else {
            let alert = UIAlertController.defaultAlert
            present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
}
