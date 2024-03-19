//
//  ContentView.swift
//  MoonShot
//
//  Created by Daniel Budusan on 22.02.2024.
//

import SwiftUI

//struct GridLayout: View {
//    let astronauts: [String: Astronaut]
//    let missions: [Mission]
//    
//    let columns = [
//        GridItem(.adaptive(minimum: 150))
//    ]
//    
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(missions) { mission in
//                    NavigationLink {
//                        MissionView(mission: mission, astronauts: astronauts)
//                    } label: {
//                        VStack {
//                            Image(mission.image)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//                                .padding()
//                            
//                            VStack {
//                                Text(mission.diplayName)
//                                    .font(.headline)
//                                    .foregroundStyle(.white)
//                                
//                                Text(mission.formattedLaunchDate)
//                                    .font(.caption)
//                                    .foregroundStyle(.gray)
//                            }
//                            .padding(.vertical)
//                            .frame(maxWidth: .infinity)
//                            .background(.lightBackground)
//                        }
//                        .clipShape(.rect(cornerRadius: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(.lightBackground)
//                        )
//                    }
//                }
//            }
//            .padding([.horizontal, .bottom])
//        }
//    }
//}

//struct ListLayout: View {
//    let astronauts: [String: Astronaut]
//    let missions: [Mission]
//    
//    var body: some View {
//        List(missions) { mission in
//            NavigationLink {
//                MissionView(mission: mission, astronauts: astronauts)
//            } label: {
//                HStack {
//                    Image(mission.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//                        .padding()
//                    VStack {
//                        Text(mission.diplayName)
//                            .font(.headline)
//                            .foregroundStyle(.white)
//                        
//                        Text(mission.formattedLaunchDate)
//                            .font(.caption)
//                            .foregroundStyle(.gray)
//                    }
//                    .padding(.vertical)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(.lightBackground)
//                }
//                
//                .clipShape(.rect(cornerRadius: 10))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(.lightBackground)
//                        .border(.lightBackground, width: 3)
//                )
//            }
//            .listRowBackground(Color.darkBackground)
//        }
//        .scrollContentBackground(.hidden)
//        .background(.darkBackground)
//    }
//}


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    //    @State private var showingGrid = true
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink(value: mission )  {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .padding()
                                
                                VStack {
                                    Text(mission.diplayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
                .navigationDestination(for: Astronaut.self) { astronaut in
                    AstronautView(astronaut: astronaut)
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
//            .toolbar {
//                if showingGrid {
//                    Button("Grid View"){
//                        showingGrid.toggle()
//                    }
//                    .buttonStyle(.bordered)
//                } else {
//                    Button("List View"){
//                        showingGrid.toggle()
//                    }
//                    .buttonStyle(.bordered)
//                }
//            }      
        }
    }
}

#Preview {
    ContentView()
}
