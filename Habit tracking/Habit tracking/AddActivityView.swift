//
//  AddActivityView.swift
//  Habit tracking
//
//  Created by Daniel Budusan on 04.03.2024.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var type = ""
    @State private var description = ""
    
    var storage: Storage
    
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Create new Activity")
                    .font(.title3).bold()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                
                TextField("Enter your activity type here", text: $type)
    
                TextField("Enter activity description", text: $description)
                Button {
                    let newActivity = Activity(type: type, description: description)
                    storage.activities.append(newActivity)
                    dismiss()
                } label: {
                    Text("Add activity")
                        .foregroundStyle(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(.blue)
                        .clipShape(.capsule(style: .circular))
                }
            
            }
            
        }
    }
}

#Preview {
    AddActivityView(storage: Storage())
}
