//
//  ContentView.swift
//  FriendFace
//
//  Created by Daniel Budusan on 18.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            List(users, id: \.id) { user in
                HStack {
                    NavigationLink(value: user) {
                        Text("\(user.name)")
                            .font(.headline)
                    }
                    .frame(width: 200)
                    Spacer()
                    Circle()
                        .foregroundStyle(user.isActive ? .green : .gray)
                        .frame(width: 15)
                }
                .padding([.top, .bottom], 10)
            }
            .listStyle(.plain)
            .navigationDestination(for: User.self) { user in
                UserView(user: user, users: $users, path: $navPath)
            }
            .task {
                if users.isEmpty {
                    await loadData()
                }
                
            }
            .navigationTitle("Friend Face")
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("invalid url")
            return
        }
        
        do  {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("invalid data")
        }
    }
}

#Preview {
    ContentView()
}
