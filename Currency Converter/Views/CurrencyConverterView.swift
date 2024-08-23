//
//  CurrencyConverterView.swift
//  Currency Converter
//
//  Created by Moody on 2024-08-23.
//

import SwiftUI

struct CurrencyConverterView: View {
    
    @ObservedObject var viewModel = CurrencyViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter amount", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Picker("Base Currency", selection: $viewModel.baseCurrency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("GBP").tag("GBP")
                    // Add more currencies as needed
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Target Currency", selection: $viewModel.targetCurrency) {
                    Text("USD").tag("USD")
                    Text("EUR").tag("EUR")
                    Text("GBP").tag("GBP")
                    // Add more currencies as needed
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Button(action: {
                    viewModel.convertCurrency()
                }) {
                    Text("Convert")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Text(viewModel.convertedAmount)
                    .font(.largeTitle)
                    .padding()

                Spacer()
            }
            .navigationTitle("Currency Converter")
            .padding()
        }
    }
}

#Preview {
    CurrencyConverterView()
}
