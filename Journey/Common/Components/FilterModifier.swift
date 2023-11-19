//
//  FilterModifier.swift
//  Journey
//
//  Created by Шарап Бамматов on 19.11.2023.
//

import SwiftUI

struct FilterModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, 13)
            .padding(.vertical, 12)
            .foregroundStyle(Color.filterColor)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 0.5)
                    .fill(.black.opacity(0.2))
            }
    }
}
