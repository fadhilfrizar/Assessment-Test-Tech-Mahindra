//
//  UserPresenter.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import Foundation

class UserPresenter {
    var view: UserView?
    
    func presentUsers(_ users: [User]) {
        self.view?.showLoading()
        self.view?.displayUsers(users)
        self.view?.stopLoading()
    }
}
