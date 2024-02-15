//
//  newFavorites.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/7/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CustomColor {
    static let background = Color("background")
    static let navyBlue = Color("navyBlue")
    static let lightGreen = Color("lightGreen")
    static let darkGreen = Color("darkGreen")
    static let newBlue = Color("newBlue")
    static let newRed = Color("newRed")
}

enum slimIcons: String, Codable {
    case cake
    case carrot
    case utensil
    case cup
    case wine
}

func randomSlimIcon()->slimIcons {
    let x = Int.random(in: 1...5)
    switch x {
    case 1:
        return .cake
    case 2:
        return .carrot
    case 3:
        return .wine
    case 4:
        return .cup
    default:
        return .utensil
    }
}

func pickSlimIcon(_ icon: slimIcons) -> String {
    
    switch icon {
    case .cake:
        return "slimCakeBG"
    case .carrot:
        return "slimCarrotBG"
    case .utensil:
        return "slimUtensilBG"
    case .cup:
        return "slimCupBG"
    case .wine:
        return "slimWineBG"
    }
    
}

struct newFavoritesPage: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var savedRecipes: [Favorites]
    
    var body: some View {
        ZStack {
            Image("foodBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            GeometryReader { geoProx in
                VStack{
                    VStack{
                        HStack{
                            Text("Favorites")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                            Spacer()
                        }
                        .padding(.top,geoProx.size.height/8)
                        .padding(.leading,geoProx.size.width/12)
                        .padding(.bottom, geoProx.size.height/30)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(CustomColor.newBlue)
                        )
                        .ignoresSafeArea()
                    }
                    VStack{
                        //                            NavigationStack {
                        List {
                            ForEach(savedRecipes) { recipe in
                                NavigationLink{
                                    newFavRecipeView(favRecipe: recipe)
                                }
                            label: {
                                ZStack{
                                    Image(pickSlimIcon(recipe.background))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    HStack{
                                        Text(recipe.name)
                                            .font(.custom("SF Pro", size: 25))
                                        Spacer()
                                        VStack {
                                            Text(recipe.time)
//                                            Text("Min.")
                                        }
                                        .font(.custom("SF Pro", size: 15))
                                    }
                                    .frame(width: 320, height: 25)
                                }
                            }
                            }
                            .onDelete(perform: deleteRecipes)
                            .foregroundColor(.white)
                            .listRowSeparator(.hidden)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.clear)
                                    .padding(7)
                                    .shadow(color: .black.opacity(0.6),radius: 3)
                            )
                        }
                        .environment(\.defaultMinListRowHeight, 25)
                        .scrollContentBackground(.hidden)
                        //                                .background(Image("foodBackground")
                        //                                    .resizable()
                        //                                    .aspectRatio(contentMode: .fill)
                        //                                    .edgesIgnoringSafeArea(.all))
                        //                            .toolbar {
                        //                                Button("Add", action: addSamples)
                        //                            }
                        //                            }
                    }
                }
            }
        }
    }
    
    //    func addSamples(){
    //        let recipe1 = Favorites(name: "Chicken", time: "15", ingredients: "Blah", instructions: "Blah", background: randomSlimIcon())
    //        let recipe2 = Favorites(name: "Steak", time: "20", ingredients: "Blah", instructions: "Blah", background: randomSlimIcon())
    //        let recipe3 = Favorites(name: "Sushi", time: "15", ingredients: "Blah", instructions: "Blah", background: randomSlimIcon())
    //
    //        modelContext.insert(recipe1)
    //        modelContext.insert(recipe2)
    //        modelContext.insert(recipe3)
    //    }
    
    func deleteRecipes(_ indexSet: IndexSet) {
        for index in indexSet {
            let recipe = savedRecipes[index]
            modelContext.delete(recipe)
        }
    }
    
}


#Preview {
    newFavoritesPage()
}
