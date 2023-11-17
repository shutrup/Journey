//
//  HomeView.swift
//  Journey
//
//  Created by Шарап Бамматов on 17.11.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = String()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    homeTitle
                    
                    CustomSearchBar(searchText: $searchText, placeholder: "Думай")
                    
                    VStack {
                        HStack {
                            Text("Рекомендации")
                                .font(.montserratSemiBold(size: 16))
                                .foregroundStyle(.black)
                            
                            Spacer()
                            
                            Text("Все")
                                .font(.montserratSemiBold(size: 16))
                                .foregroundStyle(Color.tabColor)
                        }
                        
                        
                    }
                }
                .padding(.horizontal, 20)
            }
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    private var homeTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Journey")
                    .font(.rubikRegular(size: 24))
                
                HStack(spacing: 5) {
                    Text("Махачкала")
                        .font(.montserratMedium(size: 12))
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 10, height: 6)
                }
                .padding(.leading, 5)
            }
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(.notification)
        }
    }
}
