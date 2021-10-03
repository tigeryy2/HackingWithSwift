//
//  ExampleView10.swift
//  Examples
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

/// Manually publishing observed object changes
struct ExampleView10: View {
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ExampleView10_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView10()
    }
}
