//
//  ContentView.swift
//  Navigation
//
//  Created by Daniel Budusan on 26.02.2024.
//

import SwiftUI


@Observable
class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationLink("Go to number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Home"){
                        path = NavigationPath()
                    }
                }
            }
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()
    @State private var title = "Title"
    
    var body: some View {
        
//        NavigationStack(path: $pathStore.path) {
//            DetailView(number: 0, path: $pathStore.path)
//                .navigationDestination(for: Int.self) { i in
//                    DetailView(number: i, path: $pathStore.path)
//                }
//        }
        NavigationStack {
            List(0..<100) {i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}


#Preview {
    ContentView()
}
