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
                                    Spacer(minLength: 20)
                                    HStack {
                                        Spacer()
                                    }
                                    .frame(height:geoProx.size.height/20)
                                    .padding(.top,15)
                                    Text(favRecipe.name)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    Text(favRecipe.time)
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
                                    let components = favRecipe.ingredients.components(separatedBy: " ")
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
                    .ignoresSafeArea()
                }
        }
            .toolbarBackground(.newBlue)
    }
    
}

//#Preview {
//    newFavRecipeView()
//}
