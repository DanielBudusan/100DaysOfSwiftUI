//
//  Photo.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import Foundation
import MapKit

struct Photo: Identifiable, Codable, Hashable, Comparable {
    var id = UUID()
    var name: String
    var imageData: Data
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
