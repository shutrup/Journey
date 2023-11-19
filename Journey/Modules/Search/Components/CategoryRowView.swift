//
//  CategoryRowView.swift
//  Journey
//
//  Created by Шарап Бамматов on 18.11.2023.
//

import SwiftUI

struct CategoryRowView: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.ptSansRegular(size: 15))
            .padding(.vertical, 10)
            .padding(.horizontal, 22)
            .foregroundStyle(isSelected ? .white : .black)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.tabColor : .white)
            }
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0)
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: isSelected)
    }
}

#Preview {
    CategoryRowView(text: "Пейзажи", isSelected: true)
}
