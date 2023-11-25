//
//  TourSmallCard.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct TourSmallCard: View {
    let tour: Tour
    
    var body: some View {
        HStack(spacing: 14) {
            WebImage(url: URL(string: tour.images.first!)!)
                .resizable()
                .placeholder {
                    ActivityIndicator(.constant(true))
                        .scaleEffect(2.5)
                        
                }
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width / 2.68, height: UIScreen.main.bounds.height / 5.68, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 6) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(tour.name)
                        .font(.montserratSemiBold(size: 18))
                    
                    Text(tour.place)
                        .font(.montserratRegular(size: 10))
                        .foregroundStyle(.black.opacity(0.3))
                }
                
                HStack(spacing: 3) {
                    Image(.routing)
                        .renderingMode(.original)
                    
                    Text(tour.locates.first!.title)
                        .font(.montserratRegular(size: 10))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    HStack(spacing: 3) {
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 10, height: 1)
                          .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 10, height: 1)
                          .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 10, height: 1)
                          .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                    }
                    
                    Text(tour.locates.last!.title)
                        .font(.montserratRegular(size: 10))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                
                HStack {
                    Text("Присоединяйся к:")
                        .font(.montserratRegular(size: 10))
                        .foregroundStyle(.black.opacity(0.3))
                    
                    Spacer()
                    
                    HStack(spacing: -5) {
                        ForEach(0..<4, id: \.self) { _ in
                            Image(.face)
                        }
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 16, height: 16)
                            .background(Color(red: 0.92, green: 0.92, blue: 0.92))
                            .cornerRadius(60)
                            .overlay(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 60)
                                        .inset(by: 0.25)
                                        .stroke(.white, lineWidth: 0.5)
                                    
                                    Text("+8")
                                        .font(.montserratRegular(size: 8))
                                        .foregroundStyle(.black.opacity(0.3))
                                }
                            )
                    }
                }
            }
            .padding(.vertical, 12)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 5.68)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0.0, y: 0.0)
    }
}

#Preview {
    TourSmallCard(tour: Tour.FETCH_MOCK)
}
