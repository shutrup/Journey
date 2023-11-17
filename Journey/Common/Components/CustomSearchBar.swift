//
//  CustomSearchBar.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 11) {
            Image(.searchIcon)
            
            TextField(placeholder, text: $searchText)
        }
        .padding(.horizontal, 13)
        .frame(width: UIScreen.main.bounds.width - 40, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    CustomSearchBar(searchText: .constant(""), placeholder: "Думай")
}
