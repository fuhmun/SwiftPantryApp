//
//  SplashScreen.swift
//  SwiftPantryApp
//
//  Created by Cannon Goldsby on 2/15/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var onScreen: Bool = false
    
    var body: some View {
        ZStack{
            if self.onScreen{
                newHome()
            } else{
                Rectangle()
                    .foregroundColor(.newBlue)
                    .ignoresSafeArea()
                Image("logoSC")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.onScreen = true
                }
            }
        }
        
    }
}


#Preview {
    SplashScreen()
}
