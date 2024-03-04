//
//  ContentView.swift
//  Habit tracking
//
//  Created by Daniel Budusan on 29.02.2024.
//

import SwiftUI

struct Activity: Identifiable, Equatable, Codable {
    var id = UUID()
    let type: String
    let description: String
    var timesCompleted = 1
}

@Observable
class Storage {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "activities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }
        activities = []
    }
}

struct ContentView: View {
    @State private var storage = Storage()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(storage.activities) { activity in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(activity.type)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text("Completed: \(activity.timesCompleted) times")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            NavigationLink(destination: ActivityView(activity: activity, storage: storage)) {
                                Image(systemName: "arrow.forward.square")
                                    .foregroundColor(.blue)
                                
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Divider()
                            .padding(.vertical, 4)
                            .background(Color.secondary.opacity(0.3))
                    }
                }
                .onDelete(perform: removeActivities)
                
                Spacer()
                
                NavigationLink(destination: AddActivityView(storage: storage)) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("Add New Activity")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .padding(.horizontal)
            .navigationBarTitle("Activities")
        }
    }
    
    func removeActivities(at offsets: IndexSet){
        storage.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
