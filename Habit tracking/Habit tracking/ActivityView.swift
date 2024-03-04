//
//  ActivityView.swift
//  Habit tracking
//
//  Created by Daniel Budusan on 04.03.2024.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    var storage: Storage
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(activity.type)")
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text("\(activity.description)")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    
                HStack {
                    Text("Completed: \(activity.timesCompleted) times")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        if let index = storage.activities.firstIndex(of: activity) {
                            storage.activities[index].timesCompleted += 1
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Add 1 more")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ActivityView(activity: Activity(type: "run", description: "move at a speed faster than a walk, never having both or all the feet on the ground at the same time."), storage: Storage())
}
