//
//  User.swift
//  Assessment Test Tech Mahindra
//
//  Created by USER-MAC-GLIT-007 on 25/01/23.
//

import Foundation

struct User: Decodable {
    let login: String
    let id: Int
    let avatar_url: URL
    let url: URL
    let html_url: URL
}
