//
//  LoadingScreen.swift
//  SwiftPantryApp
//
//  Created by Cannon Goldsby on 2/20/24.
//

import SwiftUI
import Foundation

struct LoadingScreen: View {
    
    @State private var jumpNum: CGFloat = 0
    @State var jumpDelay: Double = 0
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack{
                    Spacer()
                    HStack (spacing: geo.size.width / -6) {
                        Spacer()
                        Circle()
                            .frame( height: geo.size.height * 0.06)
                            .foregroundStyle(CustomColor.newRed)
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(1.0), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                            }
                        Circle()
                            .frame( height: geo.size.height * 0.06)
                            .foregroundStyle(CustomColor.newRed)
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.5), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                            }
                        Circle()
                            .frame( height: geo.size.height * 0.06)
                            .foregroundStyle(CustomColor.newRed)
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                            }
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    func jump(withDelay delay: Double) {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    jumpNum += 15
                }
            }
        }
}

#Preview {
    LoadingScreen()
}
