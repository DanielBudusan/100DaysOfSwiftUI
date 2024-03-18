//
//  User.swift
//  FriendFace
//
//  Created by Daniel Budusan on 18.03.2024.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedRegisteredDate: String {
        registered.formatted(date: .abbreviated, time: .shortened)
    }
}
