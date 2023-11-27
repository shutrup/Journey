//
//  ProfileRowView.swift
//  Journey
//
//  Created by Шарап Бамматов on 27.11.2023.
//

import SwiftUI

struct ProfileRowView: View {
    var image: String
    var title: String
    var action: () -> ()
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                HStack(spacing: 23) {
                    Image(systemName: image)
                        .imageScale(.medium)
                        .bold()
                    
                    Text(title)
                        .font(.ptSansBold(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.black)
            
            Divider()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileRowView(image: "arrow.right.to.line", title: "Выход", action: {})
}
