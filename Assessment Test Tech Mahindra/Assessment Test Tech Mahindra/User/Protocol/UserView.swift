//
//  UserView.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import Foundation

protocol UserView {
    func displayUsers(_ users: [User])
    func showLoading()
    func stopLoading()
}
