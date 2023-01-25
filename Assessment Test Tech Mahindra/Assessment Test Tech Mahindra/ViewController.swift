//
//  ViewController.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import UIKit

class ViewController: UIViewController, UserView, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(UINib(nibName: "ListTableCell", bundle: nil), forCellReuseIdentifier: "listTableCell")
        }
    }
    
    var interactor: UserInteractor!
    var presenter: UserPresenter!
    
    var users: [User] = []
    
    var filteredUsers: [User] = []
    
    var searchActive = false
    
    var currentPage = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initInteractor()
    }
    
    func initInteractor() {
        
        interactor = UserInteractor()
        presenter = UserPresenter()
        interactor.presenter = presenter
        presenter.view = self
        
        interactor.getUsers(page: currentPage)
    }
    
    func displayUsers(_ users: [User]) {
        // update the UI with the users
        DispatchQueue.main.async {
            
            for user in users {
                self.users.append(user)
                self.filteredUsers.append(user)
            }
            
            self.tableView.reloadData()
            self.isLoading = false
        }
        
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return self.filteredUsers.count
        } else {
            return self.users.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTableCell", for: indexPath) as! ListTableCell
        
        if searchActive {
            let filteredData = self.filteredUsers[indexPath.row]
            cell.listTitleLabel.text = filteredData.login
            cell.listImageView.loadImageUsingCacheWithUrlString(filteredData.avatar_url.absoluteString)
        } else {
            let usersData = self.users[indexPath.row]
            cell.listTitleLabel.text = usersData.login
            cell.listImageView.loadImageUsingCacheWithUrlString(usersData.avatar_url.absoluteString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastElement: Int = self.users.count - 1
        
        if indexPath.row == lastElement {
            guard !isLoading else { return }
            isLoading = true
            currentPage += 1
            interactor.getUsers(page: currentPage)
        }
    }
    
}


extension ViewController {
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
        if searchText == "" {
            searchActive = false
        } else {
            filteredUsers = users.filter{(user) -> Bool in
                return user.login.range(of: searchText, options: [ .caseInsensitive ]) != nil
            }
            searchActive = true
        }
        
        self.tableView.reloadData()
        
    }
}
