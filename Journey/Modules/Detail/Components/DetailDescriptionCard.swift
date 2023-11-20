//
//  DetailDescriptionCard.swift
//  Journey
//
//  Created by Шарап Бамматов on 20.11.2023.
//

import SwiftUI

struct DetailDescriptionCard: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.ptSansRegular(size: 12))
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: 90, height: 60, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.detailGrayColor.opacity(0.4), lineWidth: 1)
                )
        }
    }
}

#Preview {
    DetailDescriptionCard(title: "Длительность")
}
