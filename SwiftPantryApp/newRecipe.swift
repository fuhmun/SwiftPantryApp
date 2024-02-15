//
//  RecipeView.swift
//  Bagel5
//
//  Created by Fahad Munawar on 1/25/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreData

let mess = "chicken eggs cheese"

var arrayOfRecipes: [Favorites] = []

struct newRecipeView: View {
    
    let recipeInfo: Recipes
    
    let name2: String
    let time2: String
    let ingredients2: String
    let instructions2: String
    
    @State private var bookmarkTog = false
    
    @State private var id = UUID()
//    @State private var name: String = name2
//    @State private var time: String = ""
//    @State private var ingredients: String = ""
//    @State private var instructions: String = ""
//    @State private var background: slimIcons = .cup
    @State private var information: String = ""
    
    var name: String {
        recipeInfo.name
    }
    
    var time: String {
        recipeInfo.time
    }
    
    var instructions: String {
        recipeInfo.instructions
    }
    
    var ingredients: String {
        recipeInfo.ingredients
    }
    
    var background: slimIcons {
        randomSlimIcon()
    }
    
    var recipe: Favorites {
        Favorites(id: id, name: name2, time: time, information: information, ingredients: ingredients, instructions: instructions, background: background)
    }
    
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Favorites]
    
    var body: some View {
            ZStack{
                Image("foodBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                GeometryReader { geoProx in
                    ScrollView(.vertical) {
                        VStack (alignment: .leading) {
                            ZStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(.newBlue)
//                                    .frame(width:geoProx.size.width, height:geoProx.size.height/4)
                                    .ignoresSafeArea()
                                VStack(alignment: .leading) {
                                    Spacer(minLength: geoProx.size.height/15)
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            bookmarkTog.toggle()
                                            if bookmarkTog{
                                                modelContext.insert(recipe)
                                            } else {
                                                let id = recipe.id
                                                try? modelContext.delete(model: Favorites.self, where: #Predicate<Favorites> { favorites in
                                                    ( id == favorites.id)
                                                })
                                            }
                                        }, label: {
                                            Image(systemName: bookmarkTog ?  "heart.fill" : "heart")
                                                .font(.largeTitle)
                                                .foregroundStyle(bookmarkTog ? .newRed : .white)
                                                .frame(alignment: .trailing)
                                                .padding()
                                                .foregroundColor(.white)
                                        })
                                    }
                                    .ignoresSafeArea()
                                    .frame(height:geoProx.size.height/20)
                                    .padding(.top,15)
                                    Text(recipeInfo.name)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    Text("\(recipe.time)")
                                        .font(.title3)
                                            .foregroundColor(.white)
                                }
                                .padding()
                            }
                            VStack (alignment: .leading){
                                Spacer()
//                                VStack (alignment: .leading){
//                                    Text("Description")
//                                        .font(.title)
//                                        .padding([.leading, .top])
//                                    Divider()
//                                        .overlay(.white)
//                                    Text(description)
//                                        .padding([.leading, .bottom, .trailing])
//                                }
//                                .foregroundColor(.white)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 15.0)
//                                        .fill(CustomColor.newBlue)
//                                )
//                                .padding(.top)
//                                Spacer()
                                VStack(alignment: .leading){
                                    Text("Ingredients")
                                        .font(.title)
                                    Divider()
                                    let components = recipe.ingredients.components(separatedBy: " ")
                                    ScrollView(.horizontal){
                                        HStack {
                                            ForEach(components, id: \.self) { ingre in
                                                Text(ingre)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(CustomColor.newRed, lineWidth: 2)
                                                    )
                                            }
                                            .background(.white)
                                            .cornerRadius(10)
                                        }
                                    }
                                }
                                Spacer()
                                VStack (alignment: .leading){
                                    Text("Instructions")
                                        .font(.title)
                                        .padding([.leading, .top])
                                    Divider()
                                    Text(recipe.instructions)
                                        .padding([.leading, .bottom, .trailing])
                                }
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 15.0)
                                        .fill(CustomColor.newBlue)
                                )
                                .padding(.top)
                            }
                            .padding([.leading,.trailing],30)
                        }
                        Spacer(minLength: 50)
                    }
                    .ignoresSafeArea()
                }
        }
            .toolbarBackground(.newBlue)
    }
    
//    func addRecipes() {
//        let recipe = Favorites()
//        modelContext.insert(recipe)
//    }
//
//    func deleteRecipes(_ indexSet: IndexSet) {
//        for index in indexSet {
//            let recipe = savedRecipes[index]
//            modelContext.delete(recipe)
//        }
//    }
    
}
//#Preview {
//    newRecipeView()
//}
