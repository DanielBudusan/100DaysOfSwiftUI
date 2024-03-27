//
//  ContentView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 25.03.2024.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var photoStorage = PhotoStorage()
    @State private var imageItem: PhotosPickerItem?
    @State private var showSheet = false
    @State private var imageData = Data()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(photoStorage.photos) { photo in
                        NavigationLink(value: photo) {
                            HStack{
                                Image(uiImage: UIImage(data: photo.imageData) ?? UIImage(systemName: "photo")!)
                                    .resizable()
                                    .scaledToFit()
                                Text(photo.name)
                                    .font(.headline)
                            }
                            .frame(width: 150, height: 100)
                        }
                    }
                }
                PhotosPicker(selection: $imageItem) {
                    VStack(spacing: 15) {
                        Text("Add new Image")
                        Image(systemName: "plus")
                    }
                    .padding(10)
                    .border(.blue, width: 2)
                }
            }
            .onChange(of: imageItem) {
                if imageItem != nil {
                    pickerItemToData()
                    showSheet = true
                }
            }
            .sheet(isPresented: $showSheet) {
                AddPhotoView(storage: photoStorage, imageData: imageData)
            }
            .navigationTitle("Photo App")
            .navigationDestination(for: Photo.self) { photo in
                PhotoView(photo: photo)
            }
        }
    }
      
    func pickerItemToData() {
        Task {
            guard let data = try await imageItem?.loadTransferable(type: Data.self) else { return }
            imageData = data
        }
    }
    
}


#Preview {
    ContentView( )
}
