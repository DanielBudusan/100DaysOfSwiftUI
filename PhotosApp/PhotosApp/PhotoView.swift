//
//  PhotoView.swift
//  PhotosApp
//
//  Created by Daniel Budusan on 27.03.2024.
//

import SwiftUI
import MapKit

struct PhotoView: View {
    let photo: Photo
    
    var body: some View {
        VStack {
            VStack {
                Text(photo.name)
                    .font(.headline)
                Image(uiImage: UIImage(data: photo.imageData) ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
            }
            Text("Photo location")
            Map(initialPosition: MapCameraPosition.region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: photo.latitude, longitude: photo.longitude), span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 10 )
            )
            )) {
                Annotation(photo.name, coordinate: photo.coordinate) {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 40, height: 40)
                        .background(.white)
                        .clipShape(.circle)
                }
            }
            .frame(height: 300)
        }
    }
}

#Preview {
    PhotoView(photo: Photo(name: "test", imageData: Data(), latitude: 46, longitude: 26))
}
