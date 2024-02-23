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

var arrayOfRecipes: [Favorites] = []

struct newRecipeView: View {
    
    let recipeInfo: Recipes
    @State private var bookmarkTog = false
    @State private var id = UUID()
    @State private var information: String = ""
    var name: String { recipeInfo.name }
    var time: String { recipeInfo.time }
    var instructions: String { recipeInfo.instructions }
    var ingredients: String { recipeInfo.ingredients }
    var background: slimIcons { randomSlimIcon() }
    var recipe: Favorites { Favorites(id: id, name: name, time: time, information: information, ingredients: ingredients, instructions: instructions, background: background) }
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Favorites]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geoProx in
            ZStack{
                if colorScheme == .light{
                    Image("lightBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                } else {
                    Image("darkBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                ScrollView(.vertical) {
                    VStack (alignment: .leading) {
                        ZStack (alignment: .leading){
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(.newBlue)
                                .ignoresSafeArea()
                            VStack(alignment: .leading) {
                                Spacer(minLength: 55)
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
                                .frame(height:geoProx.size.height/20)
                                .padding(.top, 20)
                                Text(recipeInfo.name)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                HStack{
                                    Text("\(recipe.time)")
                                    Text("Minutes")
                                }
                                .font(.title3)
                                .foregroundColor(.white)
                            }
                            .padding()
                        }
                        VStack (alignment: .leading){
                            Spacer()
                            VStack(alignment: .leading){
                                Text("Ingredients")
                                    .foregroundStyle(.primary)
                                    .font(.title)
                                Divider()
                                    .overlay(.primary)
                                let components = recipe.ingredients.components(separatedBy: " ")
                                ScrollView(.horizontal){
                                    HStack {
                                        ForEach(components, id: \.self) { ingre in
                                            Text(ingre)
                                                .foregroundStyle(.primary)
                                                .multilineTextAlignment(.leading)
                                                .padding(10)
                                                .background(RoundedRectangle(cornerRadius: 10)
                                                    .fill(CustomColor.lightDark)
                                                )
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
                            VStack(alignment: .leading) {
                                    Text("Instructions")
                                        .font(.title)
                                        .padding([.leading, .top])
                                        .frame(alignment: .leading)
                                    Divider()
                                        .overlay(.white)
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
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.newBlue)
    }
}

//#Preview {
//    newRecipeView()
//}
