//
//  AstronautView.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let astronauts: [Astronaut]
    var missions: [Mission]
    let allMissions: [Mission]
    
    init(astronaut: Astronaut, astronauts: [Astronaut], allMissions: [Mission]) {
        self.astronaut = astronaut
        self.astronauts = astronauts
        self.allMissions = allMissions
        self.missions = [Mission]()
                
        // check all missions for mention of this astronaut as a crewmember. Add those to the list of missions for this astronaut
        for mission in allMissions {
            for crew in mission.crew {
                if astronaut.name.range(of: crew.name, options: .caseInsensitive) != nil {
                    self.missions.append(mission)
                }
            }
        }
        
        if self.missions.count == 0 {
            fatalError("Could not find missions for \(astronaut.name)")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibilityLabel(self.astronaut.name)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions) {
                        mission in
                        NavigationLink(
                            destination: MissionView(mission: mission, missions: self.missions, astronauts: self.astronauts)) {
                            HStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.35)
                                    .accessibilityHidden(true)
                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.title)
                                    Text(mission.formattedLaunchDate)
                                        .font(.headline)
                                }
                                .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], astronauts: astronauts, allMissions: missions)
    }
}
