//
//  MissionView.swift
//  MoonShot
//
//  Created by Daniel Budusan on 26.02.2024.
//

import SwiftUI

//{
//    AstronautView(astronaut: crewMember.astronaut)
//} label:

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionCrewView: View {
    let crewMember: CrewMember
    
    var body: some View {
        NavigationLink(value: crewMember.astronaut) {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(.capsule)
                    .overlay(
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    )
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)

                    Text(crewMember.role)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal)
        }
        
    }
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    @ViewBuilder var divider: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.4
                    }
                Text(mission.formattedLaunchDate)
                    .padding()
                    .font(.headline)
                VStack(alignment: .leading) {
                    divider
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    divider
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            MissionCrewView(crewMember: crewMember)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.diplayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
