//
//  SearchView.swift
//  Journey
//
//  Created by Шарап Бамматов on 18.11.2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel(tourDataService: TourDataService.tourDataService)
    
    private var gridItems: [GridItem] = [
        GridItem(spacing: 16),
        GridItem(spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            TourFilterView(show: $viewModel.showFilter)
                .isVisible(viewModel.showFilter)
                .zIndex(1)
            
            NavigationStack {
                VStack {
                    CustomSearchBar(searchText: $viewModel.searchText, placeholder: "Думай", isShowFilter: true, action: {
                        withAnimation {
                            viewModel.showFilter.toggle()
                        }
                    })
                    
                    categoriesList
                        .disabled(viewModel.showFilter)
                    
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 16, content: {
                            ForEach(Array(viewModel.tours.enumerated()), id: \.element) { (index, tour) in
                                TourGridCard(num: index, tour: tour)
                                    .onTapGesture {
                                        viewModel.showDetail.toggle()
                                    }
                            }
                        })
                        .padding(.horizontal, 16)
                        
                        Spacer()
                            .frame(height: 100)
                    }
                    .disabled(viewModel.showFilter)
                }
                .background(Color(.systemGray6))
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    withAnimation {
                        viewModel.showFilter = false
                    }
                    UIApplication.shared.endEditing()
                }
                .navigationDestination(isPresented: $viewModel.showDetail) {
                    DetailView()
                }
                .task {
                    await viewModel.fetchAllTours()
                }
                .refreshable {
                    Task {
                        await viewModel.fetchAllTours()
                    }
                }
                .blur(radius: viewModel.showFilter ? 5 : 0)
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
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryRowView(text: category, isSelected: viewModel.selectedCategories.contains(category))
                        .padding([.leading, .top, .bottom])
                        .onTapGesture {
                            guard viewModel.selectedCategories.contains(category) else {
                                viewModel.selectedCategories.append(category)
                                return
                            }
                            viewModel.selectedCategories.removeAll(where: { $0 == category })
                        }
                }
            }
        }
    }
}
