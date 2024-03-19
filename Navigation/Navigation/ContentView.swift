//
//  ContentView.swift
//  Navigation
//
//  Created by Daniel Budusan on 26.02.2024.
//

import SwiftUI


//@Observable
//class PathStore {
//    var path: NavigationPath {
//        didSet {
//            save()
//        }
//    }
//    
//    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
//    
//    init() {
//        if let data = try? Data(contentsOf: savePath) {
//            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//                path = NavigationPath(decoded)
//                return
//            }
//        }
//        path = NavigationPath()
//    }
//    
//    func save() {
//        guard let representation = path.codable else { return }
//        
//        do {
//            let data = try JSONEncoder().encode(representation)
//            try data.write(to: savePath)
//        } catch {
//            print("Failed to save navigation data")
//        }
//    }
//}

struct DetailView: View {
    var number: Int
    @Binding var path: [Int]
    
    var body: some View {
        
        NavigationLink("Go to number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Home"){
                        path.removeAll()
                    }
                }
            }
    }
}

struct ContentView: View {
//    @State private var pathStore = PathStore()
    @State private var path = [Int]()
    @State private var title = "Title"
    
    var body: some View {
        print(path)
        return NavigationStack(path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path)
                }
        }
        
        .toolbar(.hidden, for: .navigationBar)
    }
}



#Preview {
    ContentView()
}
