//
//  CustomTabView.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var anime
    
    let tabBarItems: [String] = [
        "home",
        "search",
        "map",
        "profile"
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .frame(width: UIScreen.main.bounds.width - 40, height: 65)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 21, x: 0, y: 1.6)
            
            HStack {
                ForEach(0..<4, id: \.self) { index in
                    HStack {
                        Spacer()
                        
                        VStack {
                            Image(tabBarItems[index])
                                .foregroundStyle(index + 1 == tabSelection ? .white : .black)
                                .scaleEffect(index + 1 == tabSelection ? 1.25 : 1)
                                .background {
                                    if index + 1 == tabSelection {
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.tabColor)
                                            .frame(width: 50, height: 50)
                                            .matchedGeometryEffect(id: "animation", in: anime)
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            tabSelection = index + 1
                        }
                    }
                }
            }
            .frame(height: 64)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainTabView()
}
