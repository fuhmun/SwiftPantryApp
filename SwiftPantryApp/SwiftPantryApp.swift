//
//  SwiftPantryApp.swift
//  SwiftPantry
//
//  Created by Fahad Munawar on 2/15/24.
//

import Foundation
import SwiftUI
import SwiftData

@main
struct SwiftPantryApp: App {
    var body: some Scene {
        WindowGroup {
//            SplashScreen()
//            picPreview()
            Home()
        }
        .modelContainer(for: [Favorites.self,Ingredients.self])
    }
}
