//
//  LoadingScreen.swift
//  SwiftPantryApp
//
//  Created by Cannon Goldsby on 2/20/24.
//

import SwiftUI
import Foundation

struct LoadingScreen: View {
    
    @State var rotate = 0.0
    @State private var jumpNum: CGFloat = 0
    @State var jumpDelay: Double = 0
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack{
                    Spacer()
                    HStack (spacing: geo.size.width / -4.25) {
                        Spacer()
                        Image("lemonRed")
                            .resizable()
                            .scaledToFit()
                            .frame( height: geo.size.height * 0.05)
                            .foregroundStyle(.black)
                            .rotationEffect(.degrees(rotate))
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(1.0), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                                withAnimation(.linear(duration: 1)
                                    .repeatForever(autoreverses: false)){
                                        rotate = 360.0
                                    }
                            }
                      
                        Image("lemonRed")
                            .resizable()
                            .scaledToFit()
                            .frame( height: geo.size.height * 0.05)
                            .foregroundStyle(.black)
                            .rotationEffect(.degrees(rotate))
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.5), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                                withAnimation(.linear(duration: 1)
                                    .repeatForever(autoreverses: false)){
                                        rotate = 360.0
                                    }
                            }
                      
                        Image("lemonRed")
                            .resizable()
                            .scaledToFit()
                            .frame( height: geo.size.height * 0.05)
                            .foregroundStyle(.black)
                            .rotationEffect(.degrees(rotate))
                            .offset(y: -jumpNum)
                            .animation(Animation.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.0), value: jumpNum)
                            .onAppear {
                                self.jump(withDelay: 0)
                                withAnimation(.linear(duration: 1)
                                    .repeatForever(autoreverses: false)){
                                        rotate = 360.0
                                    }
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
