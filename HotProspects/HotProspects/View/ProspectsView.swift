//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI

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
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                    .contextMenu {
                        // we want to show only the buttons that make sense...
                        // no point having a "mark contacted", if we're already on the contacted page
                        if self.filter != .contacted {
                            Button("Mark Contacted") {
                                self.prospects.toggle(prospect, to: true)
                            }
                        }
                        if self.filter != .uncontacted {
                            Button("Mark Uncontacted") {
                                self.prospects.toggle(prospect, to: false)
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
            
            self.prospects.people.append(person)
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
