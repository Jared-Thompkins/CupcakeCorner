//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jared Thompkins on 2/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Select your cake type", selection: $order.type) {
                            ForEach(Order.types.indices) {
                                Text(Order.types[$0])
                            }
                        }
                        
                        Stepper("Cakes: \(order.quantity) ($2.00 / Cake)", value: $order.quantity, in: 0...20)
                    }
                    
                    Section {
                        Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                        
                        if order.specialRequestEnabled {
                            Toggle("Add extra frosting (+$1.00)", isOn: $order.extraFrosting)
                            Toggle("Add extra sprinkles (+$1.00)", isOn: $order.addSprinkles)
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            AddressView(order: order)
                        } label: {
                            Text("Delivery details")
                        }
                    }
                    
                }
                Text("Order Total: \(order.cost, format: .currency(code: "USD"))")
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
