//
//  TourLargeCard.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct TourLargeCard: View {
    var body: some View {
        VStack(spacing: 3) {
            WebImage(url: URL(string: "https://2spalnika.ru/wp-content/uploads/2022/12/sulakskiy-kanion-800x600.jpg")!)
                .resizable()
                .placeholder {
                    ActivityIndicator(.constant(true))
                        .scaleEffect(2.5)
                        
                }
                .frame(width: UIScreen.main.bounds.width / 1.47, height: UIScreen.main.bounds.height / 4.36)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(alignment: .topTrailing) {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 36, height: 36)
                            
                            Image(.heart)
                                .foregroundStyle(.black)
                        }
                    }
                    .padding([.top, .trailing], 10)
                }
            
            HStack {
                Text("Ахтынский водопад")
                    .font(.ptSansBold(size: 22))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                
                Spacer()
                
                HStack(spacing: 3) {
                    Text("4.8")
                        .font(.ptSansRegular(size: 16))
                        .foregroundStyle(.black.opacity(0.3))
                    
                    Image(.star)
                        .renderingMode(.original)
                }
            }
            
            HStack(spacing: 10) {
                Image(.mark)
                    .renderingMode(.original)
                
                Text("Шамильский район")
                    .font(.ptSansRegular(size: 16))
                    .foregroundStyle(.black.opacity(0.3))
                
                Spacer()
            }
            
            Spacer()
        }
        .padding([.top, .leading, .trailing], 10)
        .frame(width: UIScreen.main.bounds.width / 1.37, height: UIScreen.main.bounds.height / 3.07)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0.0)
    }
}

#Preview {
    TourLargeCard()
}
