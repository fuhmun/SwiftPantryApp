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

struct newFavRecipeView: View {
    
    let favRecipe: Favorites
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
                                Spacer(minLength: 20)
                                HStack {
                                    Spacer()
                                }
                                .frame(height:geoProx.size.height/20)
                                .padding(.top,15)
                                Text(favRecipe.name)
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                HStack{
                                    Text(favRecipe.time)
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
                                    .font(.title)
                                    .foregroundStyle(.primary)
                                Divider()
                                    .overlay(.primary)
                                    .frame(height: 1.5)
                                    .background(.black)
                                let components = favRecipe.ingredients.components(separatedBy: " ")
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
                            VStack (alignment: .leading){
                                Text("Instructions")
                                    .font(.title)
                                    .padding([.leading, .top])
                                Divider()
                                Text(favRecipe.instructions)
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
//    newFavRecipeView()
//}
