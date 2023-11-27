//
//  FavoriteView.swift
//  Journey
//
//  Created by Шарап Бамматов on 27.11.2023.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            
        }
        .navigationTitle("Избранные")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FavoriteView(show: .constant(false))
}
