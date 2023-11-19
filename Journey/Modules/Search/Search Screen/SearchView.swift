//
//  SearchView.swift
//  Journey
//
//  Created by Шарап Бамматов on 18.11.2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = String()
    @State var categories: [String] = ["Пейзажи","Горы","Водоемы","Что то","Кто то"]
    @State var selectedCategories: [String] = []
    
    private var gridItems: [GridItem] = [
        GridItem(spacing: 16),
        GridItem(spacing: 16)
    ]
    
    var body: some View {
        VStack {
            CustomSearchBar(searchText: $searchText, placeholder: "Думай", isShowFilter: true, action: {})
            
            categoriesList
            
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16, content: {
                    ForEach(0..<10) { tour in
                        TourGridCard(num: tour)
                    }
                })
                .padding(.horizontal, 16)
            }
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    SearchView()
}

extension SearchView {
    private var categoriesList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(categories, id: \.self) { category in
                    CategoryRowView(text: category, isSelected: selectedCategories.contains(category))
                        .padding([.leading, .top, .bottom])
                        .onTapGesture {
                            guard selectedCategories.contains(category) else {
                                selectedCategories.append(category)
                                return
                            }
                            selectedCategories.removeAll(where: { $0 == category })
                        }
                }
            }
        }
    }
}
