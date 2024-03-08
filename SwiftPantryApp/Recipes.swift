//
//  Recipe.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/12/24.
//

import Foundation

class Recipes {
    var name: String
    var time: String
    var ingredients: String
    var instructions: String
    var description: String
    
    init(name: String = "", time: String = "", ingredients: String = "", instructions: String = "", description: String = "") {
        self.name = name
        self.time = time
        self.ingredients = ingredients
        self.instructions = instructions
        self.description = description
    }
}
