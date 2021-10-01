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
    
    @State private var bedTimeText: String = "12:54 AM"
    
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
                        .onChange(of: wakeUpDate, perform: { value in
                            calculateBedTime()
                        })
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                }
                
                Section {
                    Text("How much sleep do you want?")
                        .font(.headline)
                    
                    HStack {
                        Text("\(sleepAmount, specifier: "%g") hours")
                        Spacer()
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .accessibilityLabel("\(sleepAmount, specifier: "%g") hours")
                        }
                        .onChange(of: sleepAmount, perform: { value in
                            calculateBedTime()
                        })
                        .labelsHidden()
                    }
                    .accessibilityLabel("\(sleepAmount, specifier: "%g") hours of sleep")
                    .accessibilityValue("\(sleepAmount, specifier: "%g") hours")
                }
                
                Section {
                    Text("How much coffee can you afford?")
                        .font(.headline)
                    
                    Picker("", selection: $coffeeAmount) {
                        ForEach (1 ..< 11) {
                            Text("\($0) \($0 == 1 ? "cup" : "cups")")
                        }
                    }
                    .onChange(of: coffeeAmount, perform: { value in
                        calculateBedTime()
                    })
                }
                
                Section {
                    Text("Recommended Bedtime")
                        .font(.headline)
                    Text("\(bedTimeText)")
                        .font(.largeTitle)
                        .frame(maxWidth: 400, maxHeight: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    func calculateBedTime() {
        // attempt to init the model
        let model: SleepCalculator = {
            do {
                let modelConfig = MLModelConfiguration()
                return try SleepCalculator(configuration: modelConfig)
            } catch {
                bedTimeText = "The model failed while estimating your sleep..."
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
            // coffee amount is actually row (from picker) + 1
            let prediction = try model.prediction(wake: Double(hoursInSeconds + minutesInSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))
            
            let sleepTimeEstimate = wakeUpDate - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            bedTimeText = formatter.string(from: sleepTimeEstimate)
        } catch {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
