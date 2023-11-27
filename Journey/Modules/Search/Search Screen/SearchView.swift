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
                        if viewModel.tours.isEmpty {
                            Text("Результатов не нашли")
                                .padding()
                                .foregroundColor(.gray)
                        } else {
                            LazyVGrid(columns: gridItems, spacing: 16, content: {
                                ForEach(Array(viewModel.tours.enumerated()), id: \.element) { (index, tour) in
                                    TourGridCard(num: index, tour: tour)
                                        .onTapGesture {
                                            viewModel.selectedTour = tour
                                            viewModel.showDetail.toggle()
                                        }
                                }
                            })
                            .padding(.horizontal, 16)
                        }
                        
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
                    if let tour = viewModel.selectedTour {
                        DetailView(tour: tour)
                    }
                }
                .task {
                    await viewModel.fetchAllCategories()
                    await viewModel.fetchAllTours()
                }
                .refreshable {
                    Task {
                        await viewModel.fetchAllTours()
                    }
                }
                .blur(radius: viewModel.showFilter ? 5 : 0)
                .onChange(of: viewModel.selectedCategory) { oldValue, newValue in
                    if let categoryId = newValue?._id {
                        Task {
                            await viewModel.fetchByCategory(id: categoryId)
                        }
                    } else {
                        Task {                        
                            await viewModel.fetchAllTours()
                        }
                    }
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
                ForEach(viewModel.categories, id: \.self) { category in
                    CategoryRowView(category: category, isSelected: viewModel.selectedCategory == category)
                        .padding([.leading, .top, .bottom])
                        .onTapGesture {
                            if category == viewModel.selectedCategory {
                                withAnimation {
                                    viewModel.selectedCategory = nil
                                }
                            } else {
                                withAnimation {
                                    viewModel.selectedCategory = category
                                }
                            }
                        }
                }
            }
        }
    }
}
