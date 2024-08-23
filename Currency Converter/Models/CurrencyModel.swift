//
//  CurrencyModel.swift
//  Currency Converter
//
//  Created by Moody on 2024-08-23.
//

import Foundation

struct CurrencyModel: Codable {
    let base: String
    let rates: [String: Double]
}
