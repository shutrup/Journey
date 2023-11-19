//
//  TourGridCard.swift
//  Journey
//
//  Created by Шарап Бамматов on 18.11.2023.
//

import SwiftUI
import SDWebImageSwiftUI

enum TourSize {
    case large
    case medium
    case none
}

struct TourGridCard: View {
    @State private var isFavorite = true
    var num: Int
    var tourSize: TourSize {
        switch num % 4 {
        case 0:
            return .large
        case 1:
            return .medium
        case 2:
            return .medium
        case 3:
            return .large
        default:
            return .none
        }
    }
    var topPadding: CGFloat {
        switch num % 4 {
        case 0:
            return 0
        case 1:
            return -50
        case 2:
            return 0
        case 3:
            return -50
        default:
            return 0
        }
    }
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: "https://2spalnika.ru/wp-content/uploads/2022/12/sulakskiy-kanion-800x600.jpg")!)
                .resizable()
                .placeholder {
                    ActivityIndicator(.constant(true))
                        .scaleEffect(2)
                }
                .frame(height: tourSize == .large ? UIScreen.main.bounds.height / 3.22 : UIScreen.main.bounds.height / 3.92)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(alignment: .top) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.clear)
                            .frame(height: 71.05991)
                            .background(
                                LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: .black.opacity(0), location: 0.00),
                                        Gradient.Stop(color: .black.opacity(0.5), location: 0.55),
                                        Gradient.Stop(color: .black.opacity(0.7), location: 0.81),
                                        Gradient.Stop(color: .black.opacity(0.8), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: 0.61, y: 1),
                                    endPoint: UnitPoint(x: 0.6, y: 0)
                                )
                            )
                            .cornerRadius(16)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Село Гоор")
                                .font(.montserratBold(size: 18))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 6) {
                                Image(.mark)
                                    .resizable()
                                    .frame(width: 10, height: 14)
                                    .foregroundStyle(.white)
                                
                                
                                Text("Шамильский район")
                                    .font(.ptSansRegular(size: 12))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.top, -16)
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    Text("1 345$")
                        .font(.ptSansBold(size: 14))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.black.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding([.bottom, .leading], 10)
                }
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        isFavorite.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.black.opacity(0.5))
                                .frame(width: 36, height: 36)
                            
                            Image(.bookmark)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(isFavorite ? Color.white  : .tabColor)
                                .animation(.snappy, value: isFavorite)
                        }
                    }
                    .padding([.bottom, .trailing], 10)
                }
        }
        .frame(height: tourSize == .large ? UIScreen.main.bounds.height / 3.22 : UIScreen.main.bounds.height / 3.92)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        }
        .padding(.top, topPadding)
    }
}

#Preview {
    TourGridCard(num: 0)
        .previewLayout(.sizeThatFits)
}
