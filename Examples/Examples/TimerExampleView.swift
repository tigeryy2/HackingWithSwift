//
//  TimerExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/6/21.
//

import Foundation
import SwiftUI

struct TimerExampleView: View {
    @State var currentCount = 0
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // tolerance allows better energy optimization
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(currentCount)")
            .onReceive(timer) { _ in
                currentCount += 1
                
            }
    }
}

struct TimerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TimerExampleView()
    }
}
