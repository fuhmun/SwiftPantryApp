//
//  Recipe.swift
//  SwiftPantryApp
//
//  Created by Alexander Washington on 2/29/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreData
import SDWebImageSwiftUI

struct Recipe: View {
    
    let recipeInfo: Recipes
    let image: UnspalshData
    @State private var bookmarkTog = false
    @State private var id = UUID()
    @State private var information: String = ""
    var name: String { recipeInfo.name }
    var time: String { recipeInfo.time }
    var instructions: String { recipeInfo.instructions }
    var ingredients: String { recipeInfo.ingredients }
    var background: slimIcons { randomSlimIcon() }
    var recipe: Favorites { Favorites(id: id, name: name, time: time, information: information, ingredients: ingredients, instructions: instructions, background: background, picURL: image.Image.urls) }
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
                            AnimatedImage(url: URL(string: image.Image.urls["thumb"]!))
                                .resizable()
                                .frame(width: geoProx.size.width, height: geoProx.size.height/2)
                                .ignoresSafeArea()
                                .shadow(color: .black.opacity(0.5), radius: 10)
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .center)
                                )
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom)
                                )
                                .overlay (alignment: .bottomLeading){
                                    VStack(alignment: .leading) {
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
                                .clipShape(
                                    UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
                                )
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
        .toolbarBackground(CustomColor.newBlue.opacity(0.5))
        .toolbar {
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
//                    .font(.largeTitle)
                    .foregroundStyle(bookmarkTog ? .newRed : .white)
                    .frame(alignment: .trailing)
                    .padding()
                    .foregroundColor(.white)
            })
        }
    }
}
