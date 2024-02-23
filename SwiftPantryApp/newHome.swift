//
//  SwiftUIView.swift
//  SwiftPantry Proto
//
//  Created by Cannon Goldsby on 2/7/24.
//

import Foundation
import SwiftUI
import SwiftData

enum bigIcons: String, Codable {
    case cake
    case carrot
    case utensil
    case cup
    case wine
}

func randomBigIcon()->bigIcons {
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

func pickBigIcon(_ icon: bigIcons) -> String {
    switch icon {
    case .cake:
        return "bigCakeBG"
    case .carrot:
        return "bigCarrotBG"
    case .utensil:
        return "bigUtensilBG"
    case .cup:
        return "bigCupBG"
    case .wine:
        return "bigWineBG"
    }
}

struct newHome: View {
    
    @State private var search: String = ""
    @State private var ingredientListed: [String] = []
    @State private var load: Bool = false
    @State private var generatedRecipe: Recipes = Recipes(name: "", time: "", ingredients: "", instructions: "")
    @State private var isRecipeHidden: Bool = true
    @Environment(\.modelContext) var modelContext
    @Query var savedIngredients: [Ingredients]
    @FocusState private var isKeyboardUp
    let columns = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]
    @Environment(\.colorScheme) var colorScheme
    @State private var recipeBackground: bigIcons = .cup
    @State var tags: [Tag] = []
    var fontSize: CGFloat = 16
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geoProx in
                ZStack{
                    if colorScheme == .light{
                        Image("lightBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    } else {
                        Image("darkBackground")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    }
                    VStack {
                        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))
                            .fill(Color.newBlue)
                            .frame(width: geoProx.size.width/1, height: geoProx.size.height/1.6)
                            .shadow(color: .black.opacity(0.5), radius: 10)
                            .overlay(
                                VStack{
                                    HStack{
                                        Text("SwiftPantry")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
                                            .padding(.leading, geoProx.size.width/10)
                                        Spacer()
                                        NavigationLink {
                                            newFavoritesPage()
                                        } label: {
                                            Image(systemName: "heart.circle")
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                                .padding(.trailing, geoProx.size.width/10)
                                        }
                                    }
                                    .padding(.top, geoProx.size.height/18)
                                    TextField("Type ingredient", text: $search, onCommit: {isKeyboardUp = true})
                                        .focused($isKeyboardUp)
                                        
                                        .foregroundStyle(.primary)
                                        .multilineTextAlignment(.center)
                                        .fontWeight(.bold)
                                        .background(RoundedRectangle(cornerRadius: 15).fill(CustomColor.lightDark).frame(width: geoProx.size.width/1.25, height: geoProx.size.height/15))
                                        .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/15)
                                        .cornerRadius(15)
                                        .shadow(radius: 5)
                                        .padding(.top, 5)
                                        .onSubmit {
                                            if (search != ""){
                                                let selectedIngredient = Ingredients(id: UUID(),name: search)
                                                modelContext.insert(selectedIngredient)
                                                let font = UIFont.systemFont(ofSize: fontSize)
                                                let attributes = [NSAttributedString.Key.font: font]
                                                let size = (search as NSString).size(withAttributes: attributes)
                                                tags.append(Tag(name: search, size: size.width, id2: selectedIngredient.id))
                                                search = ""
                                            }
                                        }.submitLabel(.done)
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(CustomColor.lightDark)
                                            .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/4)
                                            .shadow(radius: 5)
                                            .overlay(
                                                TagView(tags: $tags)
                                                    .frame(width: geoProx.size.width/1.3, height: geoProx.size.height/4.3)
                                            )
                                    }
                                    .padding(.top, 3)
                                    .padding(.bottom, 15)
                                    Button{
                                        isKeyboardUp = false
                                        recipeBackground = randomBigIcon()
                                        var ingredientsArray: [String] = []
                                        for i in savedIngredients {
                                            ingredientsArray.append(i.name)
                                        }
                                        let ingredientString = ingredientsArray.joined(separator: " ")
                                        print(ingredientString)
//                                        if load {
//                                            LoadingScreen()
//                                        }
                                        Task {
                                            do {
                                                generatedRecipe = Recipes(name: "", time: "", ingredients: "", instructions: "")
                                                let result = try await OpenAIService.shared.sendPromptToChatGPT(message: ingredientString)
                                                print(result)
                                                generatedRecipe = Recipes(name: result.recipe, time: result.timeToCook, ingredients: result.ingredients, instructions: result.instructions)
                                            } catch {
                                                print(error.localizedDescription)
                                                isRecipeHidden = true
                                                generatedRecipe = Recipes(name: "", time: "", ingredients: "", instructions: "")
                                                showingAlert = true
                                            }
                                        }
                                        isRecipeHidden = false
                                    } label: {
                                        Text("Generate")
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/15)
                                            .background(.newRed)
                                            .cornerRadius(15)
                                    }
                                }
                            )
                        VStack {
                            if isRecipeHidden {
                                Text("No Recipes Available")
                                    .foregroundStyle(.primary)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(CustomColor.lightDark)
                                        .shadow(color: .black ,radius: 7)
                                    )
                                    .padding(.top, geoProx.size.height/7)
                            } else {
                                NavigationLink{
                                    newRecipeView(recipeInfo: generatedRecipe)
                                } label: {
                                    ZStack{
                                        Image(pickBigIcon(recipeBackground))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geoProx.size.width/1.25)
                                            .shadow(color: .black.opacity(0.5), radius: 10)
                                        VStack{
                                            Spacer()
                                            HStack{
                                                Text(generatedRecipe.name)
                                                    .font(.title)
                                                Spacer()
                                            }
                                            Spacer()
                                            HStack{
                                                Spacer()
                                                VStack{
                                                    Text(generatedRecipe.time)
                                                    Text("Min.")
                                                }
                                            }
                                            Spacer()
                                        }
                                        .frame(width: geoProx.size.width/1.5, height: geoProx.size.height/4.5)
                                    }
                                    .frame(width: geoProx.size.width/1.5, height: geoProx.size.height/4.5)
                                }
                                .padding(.top, geoProx.size.height/12)
                            }
                        }
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    isKeyboardUp = false
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .alert("An error occured while generating, please try again!", isPresented: $showingAlert){
            Button("OK", role: .cancel) {
                showingAlert = false
            }
        }
        .onAppear {
            tags = savedIngredients.map { ingredient in
                let font = UIFont.systemFont(ofSize: fontSize)
                let attributes = [NSAttributedString.Key.font: font]
                let size = (ingredient.name as NSString).size(withAttributes: attributes)
                return Tag(name: ingredient.name, size: size.width, id2: ingredient.id)
            }
        }
    }
}

#Preview {
    newHome()
}

// Technical Depth
