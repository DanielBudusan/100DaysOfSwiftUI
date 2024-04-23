//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Daniel Budusan on 10.04.2024.
//

import SwiftUI

enum SortingOption {
    case defaultCase, alphabetical, country
    
    var sortingClosure: (Resort, Resort) -> Bool {
        switch self {
        case .defaultCase:
            return { _, _ in true }
        case .alphabetical:
            return { $0.name < $1.name }
        case .country:
            return { $0.country < $1.country }
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortingOption = SortingOption.defaultCase
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts.sorted(by: sortingOption.sortingClosure)
        } else {
            return resorts.filter { $0.name.localizedStandardContains(searchText) }
                .sorted(by: sortingOption.sortingClosure)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("Sort by", selection: $sortingOption) {
                    Text("Default").tag(SortingOption.defaultCase)
                    Text("Alphabetical").tag(SortingOption.alphabetical)
                    Text("Country").tag(SortingOption.country)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List(filteredResorts) { resort in
                    NavigationLink(value: resort) {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 25)
                                .clipShape(.rect(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Resorts")
                .navigationDestination(for: Resort.self) { resort in
                    ResortView(resort: resort)
                }
                .searchable(text: $searchText, prompt: "Search for a resort")
            }
        } detail: {
            WelcomeVIew()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
