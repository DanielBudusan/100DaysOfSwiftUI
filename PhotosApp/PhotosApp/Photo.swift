//
//  Photo.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import Foundation

struct Photo: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var imageData: Data
}
