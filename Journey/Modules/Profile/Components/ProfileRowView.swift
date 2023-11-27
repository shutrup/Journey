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
                    if image == "star" {
                        Image(.bookmark)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(Color.tabColor)
                    } else {
                        Image(systemName: image)
                            .imageScale(.medium)
                            .bold()
                            .foregroundStyle(Color.tabColor)
                    }
                    
                    Text(title)
                        .font(.ptSansBold(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.black)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProfileView()
        .environmentObject(Store())
}
