//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI
import UserNotifications

import CodeScanner

enum FilterType {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    // expects a "prospects: object in env, if this is not there, app will crash
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "\((prospect.isContacted ? "person.fill.checkmark" : "person.fill.questionmark"))")
                    }
                    .contextMenu {
                        // we want to show only the buttons that make sense...
                        // no point having a "mark contacted", if we're already on the contacted page
                        if self.filter != .contacted {
                            Button(action: {
                                self.prospects.toggle(prospect, to: true)
                            }) {
                                Text("Mark Contacted")
                                Image(systemName: "person.fill.checkmark")
                            }
                        }
                        if self.filter != .uncontacted {
                            Button(action: {
                                self.prospects.toggle(prospect, to: false)
                            }) {
                                Text("Mark Uncontacted")
                                Image(systemName: "person.fill.questionmark")
                            }
                        }
                        
                        // option to remind to contact
                        if !prospect.isContacted {
                            Button(action: {
                                self.addNotification(for: prospect)
                            }) {
                                Text("Remind Me")
                                Image(systemName: "exclamationmark.bubble.fill")
                            }
                        }
                    }
                }
            }
            .navigationTitle(self.title)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.isShowingScanner = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    })
            .sheet(isPresented: self.$isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Paul Hudson\npaul@hackingwithswift.com",
                    completion: self.handleScanResult)
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        // closure that requests a notification
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            // trigger at 9 am
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        // if notifications are authorized, schedule one, otherwise, ask for permissions and try again...
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("well...")
                    }
                }
            }
        }
    }
    
    
    func handleScanResult(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        // split the expected data into components (first line name, second line email)
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            // add to prospects and save
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var prospects = Prospects()
    
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(self.prospects)
    }
}
