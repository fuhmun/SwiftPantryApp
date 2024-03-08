//
//  Recipes.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/1/24.
//

import Foundation
import SwiftData

@Model
class Favorites: Identifiable {
    
    var id = UUID()
    var name: String
    var time: String
    var information: String
    var ingredients: String
    var instructions: String
    var background: slimIcons
    var picURL: [String : String]
    
    init(id: UUID = UUID(), name: String = "", time: String = "", information: String = "", ingredients: String = "", instructions: String = "", background: slimIcons = .cup, picURL: [String : String] = ["" : ""]) {
        self.id = id
        self.name = name
        self.time = time
        self.information = information
        self.ingredients = ingredients
        self.instructions = instructions
        self.background = background
        self.picURL = picURL
    }
}

//@Model
//class Favorites: Identifiable {
//    
//    var id = UUID()
//    var name: String
//    var time: String
//    var information: String
//    var ingredients: String
//    var instructions: String
//    var background: slimIcons
//    
//    init(id: UUID = UUID(), name: String = "", time: String = "", information: String = "", ingredients: String = "", instructions: String = "", background: slimIcons = .cup) {
//        self.id = id
//        self.name = name
//        self.time = time
//        self.information = information
//        self.ingredients = ingredients
//        self.instructions = instructions
//        self.background = background
//    }
//}
