//
//  Ingredients.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/2/24.
//

import Foundation
import SwiftData

@Model
class Ingredients: Identifiable {
    var id = UUID()
    var name: String
    
    init(id: UUID = UUID(),name: String = "") {
        self.id = id
        self.name = name
    }
}
