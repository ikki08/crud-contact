//
//  ViewController.swift
//  crud contact
//
//  Created by Rizki Dwi Putra on 03/04/20.
//  Copyright © 2020 Rizki Dwi Putra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var loadingView: LoadingView!
    
    let viewModel = ViewModel()
    
    // MARK: ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTableView.isHidden = true
        contactTableView.register(UINib.init(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        getContactList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Action

    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "DashboardToDetailSegue", sender: self)
    }
    
    private func getContactList() {
        loadingView.show()
        viewModel.getContactList() { error in
            self.loadingView.hide()
            if error == nil {
                self.contactTableView.isHidden = false
                self.contactTableView.reloadData()
            } else {
                let alert = UIAlertController.defaultAlert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            if viewModel.selectedRow != -1 {
                let contact = viewModel.contactList[viewModel.selectedRow]
                destination.viewModel = DetailViewModel(contact: contact)
            } else {
                destination.viewModel = DetailViewModel()
            }
            
            destination.delegate = self
            viewModel.selectedRow = -1
        }
    }
}

// MARK: -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = viewModel.contactList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        cell.setCell(contact)
        
        return cell
    }
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedRow = indexPath.row
        performSegue(withIdentifier: "DashboardToDetailSegue", sender: self)
    }
}

// MARK: - DetailViewDelegate

extension ViewController: DetailViewDelegate {
    func addUpdateDeleteSucceed() {
        viewModel.contactList.removeAll()
        contactTableView.isHidden = true
        getContactList()
        self.navigationController?.popViewController(animated: true)
    }
}
