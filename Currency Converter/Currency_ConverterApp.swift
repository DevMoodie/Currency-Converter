//
//  Currency_ConverterApp.swift
//  Currency Converter
//
//  Created by Moody on 2024-08-23.
//

import SwiftUI

@main
struct Currency_ConverterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
