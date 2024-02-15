//
//  classForRecipe.swift
//  Bagel5
//
//  Created by Fahad Munawar on 2/1/24.
//

import Foundation

class RecipeStorage {
    var name: String
    var time: String
    var description: String
    var ingredients: String
    var instructions: String
    
    init(name: String = "", time: String = "", information: String = "", ingredients: String = "", instructions: String = "") {
        self.name = name
        self.time = time
        self.description = information
        self.ingredients = ingredients
        self.instructions = instructions
    }
     
}
    
       
