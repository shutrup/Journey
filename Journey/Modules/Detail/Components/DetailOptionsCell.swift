//
//  DetailOptionsCell.swift
//  Journey
//
//  Created by Шарап Бамматов on 20.11.2023.
//

import SwiftUI

struct DetailOptionsCell: View {
    var text: String
    
    var image: String {
        switch text {
        case "Транспорт":
            return "car"
        case "Питание":
            return "food"
        case "Байдарки":
            return "lodki"
        default:
            return ""
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if image == "car" {
                Image(image)
                    .foregroundStyle(Color.tabColor)
            } else {
                Image(image)
                    .foregroundStyle(Color.tabColor)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 5)
            }
            
            Text(text)
                .font(.ptSansRegular(size: 12))
                .foregroundStyle(Color.detailGray)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.07), radius: 2.5, x: 0, y: 0)
        }
    }
}

#Preview {
    VStack {
        DetailOptionsCell(text: "Транспорт")
        
        DetailOptionsCell(text: "Питание")
        
        DetailOptionsCell(text: "Байдарки")
    }
}
