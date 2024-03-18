//
//  UserView.swift
//  FriendFace
//
//  Created by Daniel Budusan on 18.03.2024.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    HStack {
                        Text("Age:")
                            .font(.headline)
                        Text("\(user.age)")
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading){
                        Text("Contact details:" )
                            .font(.headline)
                        Text(user.email)
                            .foregroundColor(.gray)
                        Text(user.address)
                            .foregroundColor(.gray)
                    }.padding(.top, 10)
                    
                    Text("Registered:")
                        .font(.headline)
                    Text(user.formattedRegisteredDate)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About:")
                        .font(.headline)
                    Text(user.about)
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Friends:")
                        .font(.headline)
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                            .foregroundColor(.blue)
                            .padding(.leading, 8)
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tags:")
                        .font(.headline)
                    VStack(alignment: .leading) {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding(8)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    UserView(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum  deserunt.", registered: .now, tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ], friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
                 Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Jewel Sexton")]))
}
