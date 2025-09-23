//
//  BitcoinyApp.swift
//  Bitcoiny
//
//  Created by Andrii Popov on 23.09.25.
//

import SwiftUI

@main
struct BitcoinyApp: App {
    var body: some Scene {
        WindowGroup {
            PriceList.view
        }
    }
}
