//
//  TagListView.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/13/24.
//

//import SwiftUI
//import SwiftData
//
//struct Tag: Identifiable, Hashable {
//    var id = UUID().uuidString
//    var name: String
//    var size: CGFloat = 0
//}
//
//extension UIScreen {
//    static let screenWitdh = UIScreen.main.bounds.width
//}
//
//extension String {
//    func getSize() -> CGFloat {
//        let font = UIFont.systemFont(ofSize: 16)
//        let attributes = [NSAttributedString.Key.font: font]
//        let size = (self as NSString).size(withAttributes: attributes)
//        return size.width
//    }
//}
//
//class TagListViewModel: ObservableObject {
//    
//    @Environment(\.modelContext) var modelContext
//    @Query var savedIngredients: [Tag]
//    
//    @Published var rows: [[Tag]] = []
//    
//    @Published var tags: [Tag]
//    
//    @Published var tagText = ""
//    
//    func getTags(){
//        var rows: [[Tag]] = []
//        var currentRow: [Tag] = []
//        var totalWidth: CGFloat = 0
//        let screenWidth = UIScreen.screenWitdh-20
//        let tagSpacing: CGFloat = 14 + 30 + 6 + 6
//        if(!tags.isEmpty) {
//            for index in 0..<tags.count {
//                self.tags[index].size = tags[index].name.getSize()
//            }
//            tags.forEach { ingredient in
//                totalWidth += (ingredient.size + tagSpacing)
//                if(totalWidth > screenWidth) {
//                    totalWidth = (ingredient.size + tagSpacing)
//                    rows.append(currentRow)
//                    currentRow.removeAll()
//                    currentRow.append(ingredient)
//                } else {
//                    currentRow.append(ingredient)
//                }
//            }
//            if (!currentRow.isEmpty) {
//                rows.append(currentRow)
//                currentRow.removeAll()
//            }
//            
//            self.rows = rows
//        } else {
//            self.rows = []
//        }
//    }
//    
//    init(){
//        getTags()
//    }
//}
//
//struct TagListView {
//    
//    let tags: [Ingredients]
//    
//    init(tags: [Ingredients]) {
//        self.tags = tags
//    }
//    
//    @Environment(\.modelContext) var modelContext
//    @Query var savedIngredients: [Ingredients]
//    
//    var body: some View {
//        
//        ScrollView {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
//                ForEach(tags, id: \.self) { tag in
//                    HStack {
//                        Text(tag.name)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(.white)
//                            .cornerRadius(3)
//                        Button {
//                            let id = tag.id
//                            try? modelContext.delete(model: Ingredients.self, where: #Predicate<Ingredients> { ingredientID in
//                                ( id == ingredientID.id)
//                            })
//                        } label: {
//                            Label("Delete", systemImage: "x.circle")
//                                .foregroundStyle(.black)
//                                .labelStyle(.iconOnly)
//                        }
//                    }
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 3)
//                            .stroke(CustomColor.newRed, lineWidth: 1)
//                    )
//                }
//            }
//        }
//        .padding()
//    }
//}

//#Preview {
//    TagListView()
//}
