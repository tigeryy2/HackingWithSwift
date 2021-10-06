//
//  NotificationCenterExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/6/21.
//

import Foundation
import SwiftUI

struct NotificationCenterExampleView: View {
    var body: some View {
        VStack {
            Text("Goodbye, World!")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    // triggers when user goes to the homepage, putting the app into the background
                    print("Moving to the background!")
                }
            Text("Hello, World!")
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Moving back to the foreground!")
                }
        }
    }
}

struct NotificationCenterExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCenterExampleView()
    }
}
