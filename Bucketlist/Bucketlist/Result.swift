//
//  Result.swift
//  Bucketlist
//
//  Created by Daniel Budusan on 21.03.2024.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int : Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]
}
