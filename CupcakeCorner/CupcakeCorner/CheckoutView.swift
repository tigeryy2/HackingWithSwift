//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tiger Yang on 9/12/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationAlertTitle = "Thank You!"
    @State private var confirmationAlertMessage = ""
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibilityHidden(true)
                    
                    Text("Your Total is $\(self.order.totalCost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button(action: {
                        self.placeOrder()
                    }) {
                        Text("Place Order")
                            .font(.title2)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showingConfirmationAlert) {
            Alert(title: Text(confirmationAlertTitle), message: Text(confirmationAlertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        // encode the order object
        guard let encoded = try? JSONEncoder().encode(self.order) else {
            print("Failed to encode order")
            return
        }
        
        // prepared urlrequest in order to send encoded data to server
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        // trigger data fetching in the background
        URLSession.shared.dataTask(with: request) { data, response, error in
            // check that data is returned... if it is not, then we have errored
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                
                self.confirmationAlertTitle = "Order failed"
                self.confirmationAlertMessage = "Your order could not be confirmed, server connection failed. Please check your internet connection."
                self.showingConfirmationAlert = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                
                self.confirmationAlertTitle = "YUM, Thank You!"
                self.confirmationAlertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmationAlert = true
            } else {
                print("Invalid response from server")
                
                self.confirmationAlertTitle = "Order failed"
                self.confirmationAlertMessage = "Your order could not be confirmed, server returned bad data. Please check your internet connection."
                self.showingConfirmationAlert = true
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
