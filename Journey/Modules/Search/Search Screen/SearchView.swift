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
    @State var showFilter = Bool()
    
    @State var showDetail = Bool()
    
    private var gridItems: [GridItem] = [
        GridItem(spacing: 16),
        GridItem(spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            TourFilterView(show: $showFilter)
                .isVisible(showFilter)
                .zIndex(1)
            
            NavigationStack {
                VStack {
                    CustomSearchBar(searchText: $searchText, placeholder: "Думай", isShowFilter: true, action: {
                        withAnimation {
                            showFilter.toggle()
                        }
                    })
                    
                    categoriesList
                    
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 16, content: {
                            ForEach(0..<10) { tour in
                                TourGridCard(num: tour)
                                    .onTapGesture {
                                        showDetail.toggle()
                                    }
                            }
                        })
                        .padding(.horizontal, 16)
                    }
                }
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    withAnimation {
                        showFilter = false
                    }
                    UIApplication.shared.endEditing()
                }
                .navigationDestination(isPresented: $showDetail) {
                    DetailView()
                }
            }
        }
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
