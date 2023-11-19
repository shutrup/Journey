//
//  ShowContent.swift
//  Journey
//
//  Created by Шарап Бамматов on 19.11.2023.
//

import SwiftUI

struct ShowContent: ViewModifier {
    let isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        }
    }
}

extension View {
    func isVisible(_ condition: Bool) -> some View {
        self.modifier(ShowContent(isVisible: condition))
    }
}

