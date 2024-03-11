//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Daniel Budusan on 06.03.2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
       return Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckOutView(order: order)
                }
            }
            .disabled(order.address.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
