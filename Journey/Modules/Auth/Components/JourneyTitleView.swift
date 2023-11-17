//
//  JourneyTitleView.swift
//  Journey
//
//  Created by Шарап Бамматов on 14.11.2023.
//

import SwiftUI

struct JourneyTitleView: View {
    var body: some View {
        Group {
            Text("Journey")
                .font(.rubikRegular(size: 70))
                .foregroundStyle(.white)
            
            Text("Мобильный сервис по бронированию тур поездок по Дагестану")
                .font(.rubikRegular(size: 14))
                .foregroundStyle(.white)
                .frame(width: 200)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    JourneyTitleView()
        .preferredColorScheme(.dark)
}
