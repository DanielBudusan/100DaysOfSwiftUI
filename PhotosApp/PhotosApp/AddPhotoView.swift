//
//  EditView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import SwiftUI
import PhotosUI

struct AddPhotoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var photoName = ""
    var storage: PhotoStorage
    var imageData: Data
    
    var body: some View {
        Text("Add a name for this picture")
        TextField("Name", text: $photoName)
            .textFieldStyle(.roundedBorder)
        Button("Save") {
            storage.addPhoto(imageData: imageData, name: photoName)
            dismiss()
        }
    }
}

#Preview {
    AddPhotoView(storage: PhotoStorage(), imageData: Data())
}
