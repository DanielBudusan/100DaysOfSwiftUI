//
//  ContentView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 25.03.2024.
//

import SwiftUI
import PhotosUI
import CoreLocation

struct ContentView: View {
    @State private var photoStorage = PhotoStorage()
    @State private var imageItem: PhotosPickerItem?
    @State private var showSheet = false
    @State private var imageData = Data()
    
    let locationFetcher = LocationFetcher()
    
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(photoStorage.photos.sorted()) { photo in
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
                    getCoordinates()
                    showSheet = true
                }
            }
            .sheet(isPresented: $showSheet) {
                AddPhotoView(storage: photoStorage, imageData: imageData, latitude: latitude, longitude: longitude)
            }
            .navigationTitle("Photo App")
            .navigationDestination(for: Photo.self) { photo in
                PhotoView(photo: photo)
            }
            .onAppear {
                locationFetcher.start()
            }
        }
    }
      
    func pickerItemToData() {
        Task {
            guard let data = try await imageItem?.loadTransferable(type: Data.self) else { return }
            imageData = data
        }
    }
    
    func getCoordinates() {
        if let location = locationFetcher.lastKnownLocation {
            latitude = location.latitude
            longitude = location.longitude
            print("Your location is \(location)")
        } else {
            print("Your location is unknown")
        }
    }
    
}


#Preview {
    ContentView( )
}
