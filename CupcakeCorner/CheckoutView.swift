//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jared Thompkins on 2/4/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button("Place Order") {
                Task {
                    await placeOrder()
                }
                
            }
            .padding()
            
            Spacer()
            Spacer()
            
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") { }
            }
            message: {
                Text(confirmationMessage)
            }
        }
        
        
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "You order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes to '\(decodedOrder.streetAddress)' has been placed!"
            showingConfirmation = true
        } catch {
            print("Checkout unsucessful.")
        }
    }
}
    
    
    
    
    
    
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
