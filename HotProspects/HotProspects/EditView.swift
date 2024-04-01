//
//  EditView.swift
//  HotProspects
//
//  Created by Daniel Budusan on 01.04.2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    @State private var emailAddress: String
    @State private var isContacted: Bool
    
    private let prospect: Prospect
    
    init(prospect: Prospect) {
        self.prospect = prospect
        _name = State(initialValue: prospect.name)
        _emailAddress = State(initialValue: prospect.emailAddress)
        _isContacted = State(initialValue: prospect.isContacted)
    }
    
    var body: some View { 
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email Address", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Toggle("Contacted", isOn: $isContacted)
                .padding()
            
            Spacer()
            
            Button("Save") {
                prospect.name = name
                prospect.emailAddress = emailAddress
                prospect.isContacted = isContacted
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Edit Prospect")
    }
}

#Preview {
    EditView(prospect: Prospect(name: "asad", emailAddress: "asda", isContacted: false))
        .modelContainer(for: Prospect.self)
}
