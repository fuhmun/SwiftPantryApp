//
//  TagListView.swift
//  Bagel5
//
//  Created by Alexander Washington on 2/13/24.
//

import SwiftUI
import SwiftData

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var size: CGFloat
    var id2 = UUID()
}

struct TagView: View {
    
    var maxLimit: Int = 150
    @Binding var tags: [Tag]
    var fontSize: CGFloat = 16
    @Environment(\.modelContext) var modelContext
    @Query var savedIngredients: [Ingredients]
    
    var body: some View {
        GeometryReader{ geoProx in
            VStack(alignment: .leading, spacing: 15) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(geoProx),id: \.self) { rows in
                            HStack(spacing:5) {
                                ForEach(rows) { row in
                                    RowView(tag: row)
                                }
                            }
                        }
                    }
                    .frame(width: geoProx.size.width/1, alignment: .leading)
                    .padding(.vertical)
                }
                .frame(maxWidth: .infinity)
            }
            .onChange(of: tags) {
                guard let last = tags.last else {
                    return
                }
                let font = UIFont.systemFont(ofSize: fontSize)
                let attributes = [NSAttributedString.Key.font: font]
                let size = (last.name as NSString).size(withAttributes: attributes)
                tags[getIndex(tag: last)].size = size.width
            }
        }
    }
    
    @ViewBuilder
    func RowView(tag: Tag)->some View{
        HStack {
            Text(tag.name)
                .foregroundStyle(.primary)
                .padding(.vertical, 3)
                .padding(.leading, 3)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.white)
                )
                .lineLimit(1)
            Button {
                let id = tag.id2
                try? modelContext.delete(model: Ingredients.self, where: #Predicate<Ingredients> { ingredientID in
                    ( id == ingredientID.id)
                })
                tags.remove(at: getIndex(tag: tag))
            } label: {
                Label("Delete", systemImage: "x.circle")
                    .foregroundStyle(CustomColor.text)
                    .labelStyle(.iconOnly)
            }
            .padding(.trailing,3)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(CustomColor.newRed, lineWidth: 1.2)
        )
        .padding(1)
    }
    
    func getIndex(tag: Tag)->Int {
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        return index
    }
    
    func getRows(_ boxWidth: GeometryProxy)->[[Tag]]{
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var totalWidth: CGFloat = 0
        let screenWidth: CGFloat = boxWidth.size.width
        tags.forEach { tag in
            totalWidth += (tag.size + 50)
            if totalWidth > screenWidth {
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 50) : 0)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
                
            } else {
                currentRow.append(tag)
            }
        }
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        return rows
    }
}

#Preview {
    newHome()
}

func addTag(tags: [Tag], name: String, fontSize: CGFloat,maxLimit: Int, completion: @escaping (Bool,Tag)->()){
    let font = UIFont.systemFont(ofSize: fontSize)
    let attributes = [NSAttributedString.Key.font: font]
    let size = (name as NSString).size(withAttributes: attributes)
    
    let tag = Tag(name: name, size: size.width)
    
    if (getSize(tags: tags) + name.count) > maxLimit {
        completion(false, tag)
    } else {
        completion(true, tag)
    }
}

func getSize(tags: [Tag])->Int {
    var count: Int = 0
    
    tags.forEach { tag in
        count += Int(tag.size)
    }
    return count
}
// Edge cases
