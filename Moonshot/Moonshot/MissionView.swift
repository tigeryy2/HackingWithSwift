//
//  MissionView.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let missions: [Mission]
    let crewMembers: [CrewMember]
    let astronauts: [Astronaut]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    init(mission: Mission, missions: [Mission], astronauts: [Astronaut]) {
        self.mission = mission
        self.missions = missions
        self.astronauts = astronauts
        
        // match crew listed in mission with astronaut listed in astronauts
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        // save astronaut info matched to mission
        self.crewMembers = matches
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            ScrollView(.vertical) {
                VStack {
                    Group {
                        GeometryReader {
                            imageGeo in
                            Image(self.mission.imageName)
                                .resizable()
                                .scaledToFit()
                                .position(x: imageGeo.size.width / 2, y: imageGeo.size.height / 2)
                                .frame(maxWidth: max(imageGeo.frame(in: .global).midX + 100, 150), maxHeight: max(imageGeo.frame(in: .global).midY + 100, 150))
                        }
                        .frame(minWidth: 250, minHeight: 250)
                        
                        Text("Launched \(self.mission.formattedLaunchDate)")
                            .font(.headline)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(self.mission.displayName), launched \(self.mission.formattedLaunchDate)")
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.crewMembers, id:\.role) {
                        crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut, astronauts: self.astronauts, allMissions: self.missions)) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                        .overlay(RoundedRectangle(cornerRadius: 25).stroke((crewMember.role == "Commander") ? Color.yellow : Color.primary, lineWidth: 2))
                                        .accessibilityHidden(true)
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor((crewMember.role.starts(with: "Commander")) ? .yellow : .secondary)
                                    }
                                    .accessibilityElement(children: .combine)
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], missions: missions, astronauts: astronauts)
    }
}
