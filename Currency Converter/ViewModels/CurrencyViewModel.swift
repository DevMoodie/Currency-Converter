//
//  CurrencyViewModel.swift
//  Currency Converter
//
//  Created by Moody on 2024-08-23.
//

import Foundation
import Combine

class CurrencyViewModel: ObservableObject {
    @Published var baseCurrency: String = "USD"
    @Published var targetCurrency: String = "EUR"
    @Published var amount: String = ""
    @Published var convertedAmount: String = "--"
    @Published var errorMessage: String?
    
    private let apiKey = "YOUR_API_KEY_HERE"
    private var cancellables = Set<AnyCancellable>()
    
    func convertCurrency() {
        guard let amountValue = Double(amount) else {
            self.errorMessage = "Invalid Amount"
            return
        }
        
        let urlString = "https://api.exchangerate-api.com/v4/latest/\(baseCurrency)"
        
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CurrencyModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = "Failed to fetch rates: \(error.localizedDescription)"
                case .finished:
                    break
                }
            } receiveValue: { currencyModel in
                if let rate = currencyModel.rates[self.targetCurrency] {
                    let convertedValue = amountValue * rate
                    self.convertedAmount = String(format: "%.2f", convertedValue)
                    self.errorMessage = nil
                } else {
                    self.errorMessage = "Failed to Convert"
                }
            }
            .store(in: &cancellables)

    }
}
