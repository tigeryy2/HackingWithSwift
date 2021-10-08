//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Tiger Yang on 10/8/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var toReplaceCards: Bool = true
    
    let onDismiss: (Bool) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Replace Incorrect Cards?", isOn: self.$toReplaceCards)
                }
            }
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
    
    func dismiss() {
        onDismiss(toReplaceCards)
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(onDismiss: { _ in return })
    }
}
