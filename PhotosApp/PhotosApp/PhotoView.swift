//
//  PhotoView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo
    
    var body: some View {
        VStack {
            Text(photo.name)
                .font(.headline)
            Image(uiImage: UIImage(data: photo.imageData) ?? UIImage(systemName: "photo")!)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    PhotoView(photo: Photo(name: "test", imageData: Data()))
}
