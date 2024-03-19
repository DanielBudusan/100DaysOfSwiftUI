//
//  ContentView.swift
//  SwiftDataPractice
//
//  Created by Daniel Budusan on 13.03.2024.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
                Button("delete") {
                    modelContext.delete(user)
                }
                
            }
            .navigationTitle("Users")   
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
