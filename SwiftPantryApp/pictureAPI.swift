//
//  pictureAPI.swift
//  SwiftPantryApp
//
//  Created by Alexander Washington on 2/24/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct Photo : Identifiable, Decodable, Hashable {
    var id: String
    var urls : [String : String]
}

class UnspalshData : ObservableObject {
    
    @Published var Image: Photo = Photo(id: "", urls: ["" : ""])
    var recipeName: String
    
    init(recipeName: String) {
        self.recipeName = recipeName
        SearchData()
    }
    
    func SearchData(){
        let key = ""
        let query = recipeName.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.unsplash.com/photos/random/?count=1&query=\(query)&client_id=\(key)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            do {
                let json = try JSONDecoder().decode([Photo].self, from: data!)
                print(json)
                DispatchQueue.main.async {
                    self.Image = Photo(id: json[0].id, urls: json[0].urls)
                }
            }
            catch {
//                DispatchQueue.main.async {
                    self.Image.id = ""
                    print(error.localizedDescription)
//                }
            }
        }
        .resume()
    }
}

struct picPreview : View {
    
    @State var search = "Cars"
    @ObservedObject private var randomImage: UnspalshData
    
//    init() {
//        randomImage = UnspalshData(recipeName: search)
//    }
    
    var body: some View {
        GeometryReader { geoProx in
            ZStack {
                VStack {
                    
                    if (self.randomImage.Image.id == ""){
                        
                        
                        
                    } else {
                        
                        AnimatedImage(url: URL(string: randomImage.Image.urls["thumb"]!))
                            .resizable()
                            .frame(width: 300, height: 300)
                        
                    }
                }
            }
        }
    }
}

//#Preview {
//    picPreview()
//}
