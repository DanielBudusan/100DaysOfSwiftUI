//
//  ContentView.swift
//  Bucketlist
//
//  Created by Daniel Budusan on 20.03.2024.
//

import MapKit
import SwiftUI



struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 10 )
        )
    )
    
    @State private var viewModel = ViewModel()
    @State private var mapModeHybrid = true
    
    var body: some View {
        NavigationStack {
            if viewModel.isUnlocked {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 40, height: 40)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapModeHybrid ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) { newLocation in
                            viewModel.update(location: newLocation)
                            
                        }
                    }
                }
                .toolbar {
                    Button(mapModeHybrid ? "Hybrid" : "Standard ") {
                        mapModeHybrid.toggle()
                    }
                    .buttonStyle(.bordered)
                    .background(.white)
                }
                .toolbarBackground(.hidden)
                
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .alert(viewModel.alertMessage, isPresented: $viewModel.showingAlert) {
                        Button("Ok") { }
                    }
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}
