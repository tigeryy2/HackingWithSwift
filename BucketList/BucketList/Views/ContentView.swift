//
//  ContentView.swift
//  BucketList
//
//  Created by Tiger Yang on 9/26/21.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingUnlockFailureAlert = false
    @State private var unlockFailureMessage: String = ""
    @State private var unlockFailureTitle: String = "Could Not Unlock!?!"
    
    var body: some View {
        ZStack {
            if (self.isUnlocked) {
                // app is locked, do not show content
                UnlockedContentView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .frame(width: 150, height: 150)
                .background(Color.blue.opacity(0.60))
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(Circle().stroke().foregroundColor(.gray.opacity(0.5)))
            }
        }
        .alert(isPresented: self.$showingUnlockFailureAlert) {
            Alert(title: Text(self.unlockFailureTitle), message: Text(self.unlockFailureMessage), dismissButton: .default(Text("Oops")))
        }
    }
    
    func authenticate() {
        // remember to update the info.plist with reason for using faceId...
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.unlockFailureMessage = "Authentication failed, biometrics did not match!"
                        self.showingUnlockFailureAlert = true
                    }
                }
            }
        } else {
            // no biometrics
            self.unlockFailureMessage = "Authentication failed, no biometrics available!"
            self.showingUnlockFailureAlert = true
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
