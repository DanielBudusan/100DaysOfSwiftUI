//
//  ContentView.swift
//  UnitConverter
//
//  Created by Daniel Budusan on 09.02.2024.
//

import SwiftUI

struct ContentView: View {
  
  @State private var chosenUnit: Unit = .Millimetre
  @State private var value: Double = 0
  @State private var convertToUnit: Unit = .Inch
  
  enum Unit: Double, CustomStringConvertible, CaseIterable {
    case Millimetre = 1
    case Centimeter = 10
    case Meter = 1000
    case Kilometre = 1000000
    case Inch = 25.4
    case Foot = 304.8
    case Mile = 1609000
    
    var description: String {
      switch self {
      case .Millimetre: return "Millimetre"
      case .Centimeter: return "Centimeter"
      case .Meter: return "Meter"
      case .Kilometre: return "Kilometre"
      case .Inch: return "Inch"
      case .Foot: return "Foot"
      case .Mile: return "Mile"
      }
    }
  }
  
  var convertedValue: Double {
    
    return value * chosenUnit.rawValue / convertToUnit.rawValue
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Enter value    ") {
          TextField("Enter Value", value: $value, format: .number)
            .keyboardType(.decimalPad)
          
          Picker("Measurement unit: ", selection: $chosenUnit ) {
            ForEach(Unit.allCases, id: \.self) {
              Text($0.description)
            }
          }
          .pickerStyle(.menu)
        }
        
        Text("=")

        Section {
          Text(convertedValue, format: .number)
          
          Picker("Measurement unit: ", selection: $convertToUnit ) {
            ForEach(Unit.allCases, id: \.self) {
              Text($0.description)
            }
          }
          .pickerStyle(.menu)
          
        }
        
      }
      .navigationTitle("Unit Converter")
    }
  }
}

#Preview {
  ContentView()
}
