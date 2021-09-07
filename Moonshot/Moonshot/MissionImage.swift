//
//  MissionImage.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

struct MissionImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)
    }
}

struct MissionImage_Previews: PreviewProvider {
    static var previews: some View {
        MissionImage(imageName: "apollo14")
    }
}
