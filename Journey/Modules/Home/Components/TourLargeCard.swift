//
//  TourLargeCard.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct TourLargeCard: View {
    let tour: Tour
    @State private var isFavorite = true
    
    var body: some View {
        VStack(spacing: 3) {
            WebImage(url: URL(string: tour.images.first!)!)
                .resizable()
                .placeholder {
                    ActivityIndicator(.constant(true))
                        .scaleEffect(2.5)
                        
                }
                .frame(width: UIScreen.main.bounds.width / 1.47, height: UIScreen.main.bounds.height / 4.36)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .overlay(alignment: .topTrailing) {
                    Button {
                        isFavorite.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 36, height: 36)
                            
                            Image(.bookmark)
                                .foregroundStyle(isFavorite ? Color.tabColor  : .black)
                                .animation(.snappy, value: isFavorite)
                        }
                    }
                    .padding([.top, .trailing], 10)
                }
            
            HStack {
                Text(tour.name)
                    .font(.ptSansBold(size: 22))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                
                Spacer()
                
                HStack(spacing: 3) {
                    Text(String(format: "%.1f", tour.rating))
                        .font(.ptSansRegular(size: 16))
                        .foregroundStyle(.black.opacity(0.3))
                    
                    Image(.star)
                        .renderingMode(.original)
                }
            }
            
            HStack(spacing: 10) {
                Image(.mark)
                    .renderingMode(.original)
                
                Text(tour.place)
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
    }
}

#Preview {
    TourLargeCard(tour: Tour.FETCH_MOCK)
}
