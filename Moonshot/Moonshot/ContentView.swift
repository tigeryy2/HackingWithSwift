//
//  ContentView.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingLaunchDates: Bool = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, missions: self.missions, astronauts: self.astronauts)) {
                    MissionImage(imageName: mission.imageName)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showingLaunchDates {
                            HStack {
                                Text(mission.formattedLaunchDate)
                            }
                        } else {
                            HStack{
                                ForEach(mission.crew, id: \.name) {
                                    thisCrew in
                                    Text("\(thisCrew.name)")
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button(showingLaunchDates ? "Show Crew" : "Show Date") { self.pressedLaunchDateToggleButton()})
        }
    }
    
    func pressedLaunchDateToggleButton() {
        showingLaunchDates.toggle()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
