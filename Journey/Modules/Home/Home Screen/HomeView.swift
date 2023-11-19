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
                    
                    CustomSearchBar(searchText: $searchText, placeholder: "Думай", isShowFilter: false, action: {})
                    
                    tourLargeCardList
                    
                    tourSmallCardList
                }
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
            
            Button {
                
            } label: {
                Image(.notification)
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal, 20)
    }
    private var tourLargeCardList: some View {
        VStack {
            HStack {
                Text("Рекомендации")
                    .font(.montserratBold(size: 16))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Все")
                        .font(.montserratSemiBold(size: 16))
                        .foregroundStyle(Color.tabColor)
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { _ in
                        TourLargeCard()
                            .padding(10)
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
    private var tourSmallCardList: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Можно присоединится")
                    .font(.montserratBold(size: 16))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Все")
                        .font(.montserratSemiBold(size: 16))
                        .foregroundStyle(Color.tabColor)
                }
            }
            .padding(.horizontal, 20)
            
            LazyVStack(spacing: 20) {
                ForEach(0..<5, id: \.self) { _ in
                    TourSmallCard()
                }
            }
        }
    }
}
