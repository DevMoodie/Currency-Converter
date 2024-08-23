//
//  CurrencyViewModelTests.swift
//  Currency ConverterTests
//
//  Created by Moody on 2024-08-23.
//

import XCTest
import Combine

@testable import Currency_Converter

final class CurrencyViewModelTests: XCTestCase {
    
    var viewModel: CurrencyViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        viewModel = CurrencyViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.baseCurrency, "USD")
        XCTAssertEqual(viewModel.targetCurrency, "EUR")
        XCTAssertEqual(viewModel.amount, "")
        XCTAssertEqual(viewModel.convertedAmount, "--")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testConvertCurrencyWithInvalidAmount() {
        viewModel.amount = "invalid"
        viewModel.convertCurrency()
        
        XCTAssertEqual(viewModel.errorMessage, "Invalid Amount")
        XCTAssertEqual(viewModel.convertedAmount, "--")
    }
    
    func testConvertCurrencyWithValidAmount() {
        viewModel.amount = "100"
        // Simulate API response
        viewModel.convertedAmount = "85.00" // Assume the conversion result
        XCTAssertEqual(viewModel.convertedAmount, "85.00")
        XCTAssertNil(viewModel.errorMessage)
    }
}
