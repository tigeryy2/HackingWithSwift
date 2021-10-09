//
//  CustomAlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by Tiger Yang on 10/9/21.
//

import SwiftUI

extension VerticalAlignment {
    // enum better as we can't instance it
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideView: View {
    var body: some View {
        // aligns everything inside the Hstack using 'midAccountAndName'
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("Testing...")
                // views aligned by center of this text view..
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("tree")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("hello?")
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
                Text("howdy")
            }
        }
    }
}

struct CustomAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuideView()
    }
}
