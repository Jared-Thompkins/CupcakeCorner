//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jared Thompkins on 2/4/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var isLoading = true
    
    var body: some View {
    
        ScrollView {
            VStack {
                Image("Cupcake 1")
                    .resizable()
                    
                    .onAppear() {
                        self.isLoading = false
                    }
            }
            .frame(height: 233)
            if isLoading {
                ProgressView()
            }
            
            Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                .font(.title)
            
            Button("Place Order", action: {})
                .padding()
    
        }
       
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
