//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/15/21.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            // Prevent text from wrapping when the spacer could still shrink
            Text("Elevation: \(resort.elevation)m").layoutPriority(1)
            // space only in landscape mode
            Spacer().frame(height: 0)
            Text("Snow: \(resort.snowDepth)cm").layoutPriority(1)
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SkiDetailsView(resort: Resort.example)
        }
    }
}
