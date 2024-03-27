//
//  EditView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import SwiftUI
import PhotosUI

//VStack {
//    Button("Start Tracking Location") {
//        locationFetcher.start()
//    }
//    
//    Button("Read Location") {
//        if let location = locationFetcher.lastKnownLocation {
//            print("Your location is \(location)")
//        } else {
//            print("Your location is unknown")
//        }
//    }
//}

struct AddPhotoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var photoName = ""
    var storage: PhotoStorage
    var imageData: Data
    var latitude: Double
    var longitude: Double
    
    var body: some View {
        Form {
            Text("Add a name for this picture")
            TextField("Name", text: $photoName)
                .textFieldStyle(.roundedBorder)
            Button("Save") {
                storage.addPhoto(imageData: imageData, name: photoName, latitude: latitude, longitude: longitude)
                dismiss()
            }
        }
    }
}

#Preview {
    AddPhotoView(storage: PhotoStorage(), imageData: Data(), latitude: 23, longitude: 20)
}
