//
//  DetailOptionsCell.swift
//  Journey
//
//  Created by Шарап Бамматов on 20.11.2023.
//

import SwiftUI

struct DetailOptionsCell: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(image)
                .foregroundStyle(Color.tabColor)
            
            Text(text)
                .font(.ptSansRegular(size: 12))
                .foregroundStyle(Color.detailGray)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.07), radius: 2.5, x: 0, y: 0)
        }
    }
}

#Preview {
    DetailOptionsCell(image: "car", text: "Транспорт")
}
