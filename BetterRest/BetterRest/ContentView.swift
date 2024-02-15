//
//  ContentView.swift
//  BetterRest
//
//  Created by Daniel Budusan on 14.02.2024.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var bedTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeAmount)))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
           
        } catch {
            return Date.now
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up ?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .headerProminence(.increased)
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                .headerProminence(.increased)
                
                Section("Daily coffee intake") {
                    Picker("Cups per day", selection: $coffeAmount){
                        ForEach((1...20), id: \.self){ nr in
                            Text(nr == 1 ? "1 cup" : "\(nr) cups")
                        }
                    }
                }
                .headerProminence(.increased)
                
                Section("Your bed time should be:") {
                    Text(bedTime.formatted(date: .omitted, time: .shortened)).font(.system(size: 30)).foregroundStyle(.blue)
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Better Rest")
        }
    }
}

#Preview {
    ContentView()
}
