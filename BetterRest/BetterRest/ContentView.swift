//
//  ContentView.swift
//  BetterRest
//
//  Created by Tiger Yang on 8/23/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpDate: Date = defaultWakeDate
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 1
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    static var defaultWakeDate: Date {
        var components = DateComponents()
        components.hour = 9
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you need to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time",
                               selection: $wakeUpDate,
                               displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                }
                
                Section {
                    Text("How much sleep do you want?")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g")")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                Section {
                    Text("How much coffee can you afford?")
                        .font(.headline)
                    
                    Picker("", selection: $coffeeAmount) {
                        ForEach (1 ..< 11) {
                            Text("\($0) \($0 == 1 ? "cup" : "cups")")
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(
                trailing:
                    Button(action: calculateBedTime) {
                        Text("Calculate")
                    }
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func calculateBedTime() {
        // attempt to init the model
        let model: SleepCalculator = {
            do {
                let modelConfig = MLModelConfiguration()
                return try SleepCalculator(configuration: modelConfig)
            } catch {
                alertTitle = "Calculation Error"
                alertMessage = "The model failed while estimating your sleep..."
                fatalError("Calculation Error")
            }
        }()
        
        // extract hours and minutes from the date picker
        let DateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpDate)
        
        // model has time in seconds...
        let hoursInSeconds = (DateComponents.hour ?? 0) * 60 * 60
        let minutesInSeconds = (DateComponents.minute ?? 0) * 60
        
        // attempt a prediction
        do {
            let prediction = try model.prediction(wake: Double(hoursInSeconds + minutesInSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTimeEstimate = wakeUpDate - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertTitle = "Your dream bedtime is"
            alertMessage = formatter.string(from: sleepTimeEstimate)
        } catch {
            
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
