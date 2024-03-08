//
//  favRecipe.swift
//  SwiftPantryApp
//
//  Created by Alexander Washington on 3/4/24.
//

import Foundation
import SwiftUI
import SwiftData
import CoreData
import SDWebImageSwiftUI

struct FavRecipeView: View {
    
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
                            AnimatedImage(url: URL(string: favRecipe.picURL["thumb"]!))
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
                                        Text(favRecipe.name)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                        HStack{
                                            Text("\(favRecipe.time)")
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
                                    .font(.title)
                                    .foregroundStyle(.primary)
                                Divider()
                                    .overlay(.primary)
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
                            VStack(alignment: .leading) {
                                    Text("Instructions")
                                        .font(.title)
                                        .padding(.top)
                                        .padding(.leading, geoProx.size.width/20)
                                        .frame(alignment: .leading)
                                    Divider()
                                        .overlay(.white)
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
