//
//  FavoriteView.swift
//  Journey
//
//  Created by Шарап Бамматов on 27.11.2023.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var viewModel = SearchViewModel(tourDataService: TourDataService.tourDataService)
    @Binding var show: Bool
    @State var isFavorite: Bool = false
    
    var gridItems: [GridItem] = [
        GridItem(spacing: 16),
        GridItem(spacing: 16)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 16, content: {
                    ForEach(Array(viewModel.tours.prefix(3).enumerated()), id: \.element) { (index, tour) in
                        TourGridCard(isFavorite: $isFavorite, num: index, tour: tour)
                            .onTapGesture {
                                viewModel.selectedTour = tour
                                viewModel.showDetail.toggle()
                            }
                    }
                })
                .padding(.horizontal, 16)
                
                Spacer()
                    .frame(height: 100)
            }
        }
        .task {
            Task {
                await viewModel.fetchAllTours()
            }
        }
        .navigationTitle("Избранные")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FavoriteView(show: .constant(false))
    }
}
