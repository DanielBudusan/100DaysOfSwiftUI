//
//  Order.swift
//  CupcakeCorner
//
//  Created by Daniel Budusan on 06.03.2024.
//

import Foundation

@Observable
class Address: Codable {
    enum CodingKeys: String, CodingKey {
          case _name = "name"
          case _city = "city"
          case _streetAddress = "streetAddress"
          case _zip = "zip"
      }
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
            city.trimmingCharacters(in: .whitespaces).isEmpty ||
            zip.trimmingCharacters(in: .whitespaces).isEmpty
            
        {
            return false
        }
        
        return true
    }
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
          case _type = "type"
          case _quantity = "quantity"
          case _specialRequestEnabled = "specialRequestEnabled"
          case _extraFrosting = "extraFrosting"
          case _addSprinkles = "addSprinkles"
      }
    
    var address = Address()
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
   
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity)
        }
        return cost
    }
    
 
}
