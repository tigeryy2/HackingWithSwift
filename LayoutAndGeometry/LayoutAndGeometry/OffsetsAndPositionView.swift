//
//  OffsetsAndPositionView.swift
//  LayoutAndGeometry
//
//  Created by Tiger Yang on 10/9/21.
//

import SwiftUI

struct OffsetsAndPositionView: View {
    var body: some View {
        VStack {
            // Too position, the child view needs to take up the entire area alloted by the parent in order to have control over position
            Text("Howdy Fam")
                .background(Color.red)
                .position(x: 100, y: 100)
                .background(Color.blue)
            
            // offset retains original geometry, but changes where it is rendered.
            // in this case, since the background view is not offsetted, it defaults to the center
            Text("Offsets...")
                .offset(x: 100, y: 0)
                .background(Color.orange)
            
            // background also offsetted
            Text("Offsets last...")
                .background(Color.green)
                .offset(x: -100)
        }
    }
}

struct OffsetsAndPositionView_Previews: PreviewProvider {
    static var previews: some View {
        OffsetsAndPositionView()
    }
}
