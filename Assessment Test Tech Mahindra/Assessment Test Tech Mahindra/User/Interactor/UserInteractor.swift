//
//  UserInteractor.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import Foundation

class UserInteractor {
    
    var presenter: UserPresenter?
    
    func getUsers(page: Int) {
        guard let url = URL(string: "https://api.github.com/users?page=\(page)&per_page=30") else { return }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data)
                self.presenter?.presentUsers(users)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
