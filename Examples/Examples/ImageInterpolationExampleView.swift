//
//  ImageInterpolationExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI

struct ImageInterpolationExampleView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationExampleView()
    }
}
