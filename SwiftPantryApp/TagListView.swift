//
//  TagListView.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/13/24.
//

import SwiftUI
import SwiftData

struct TagListView: View {
    
    let tags: [Ingredients]
    
    init(tags: [Ingredients]) {
        self.tags = tags
    }
    
    @Environment(\.modelContext) var modelContext
    @Query var savedIngredients: [Ingredients]
    
    var body: some View {
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))], spacing: 0) {
            ForEach(tags, id: \.self) { tag in
                HStack {
                    Text(tag.name)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.white)
                        .cornerRadius(3)
                    //                        .frame(maxWidth: .infinity)
                    Button {
                        let id = tag.id
                        try? modelContext.delete(model: Ingredients.self, where: #Predicate<Ingredients> { ingredientID in
                            ( id == ingredientID.id)
                        })
                    } label: {
                        Label("Delete", systemImage: "x.circle")
                            .foregroundStyle(.black)
                            .labelStyle(.iconOnly)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.black), lineWidth: 1)
                )
            }
        }
        
    }
}

//#Preview {
//    TagListView()
//}
