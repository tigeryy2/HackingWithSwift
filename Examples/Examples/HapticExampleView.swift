//
//  HapticExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/5/21.
//

import SwiftUI

struct HapticExampleView: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture(perform: simpleSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct HapticExampleView_Previews: PreviewProvider {
    static var previews: some View {
        HapticExampleView()
    }
}
