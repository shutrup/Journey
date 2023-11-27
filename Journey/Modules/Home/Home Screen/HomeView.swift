import SwiftUI

struct HomeView: View {
    @EnvironmentObject var store: Store
    @StateObject var viewModel = HomeViewModel(tourDataService: TourDataService.tourDataService)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    homeTitle
                    
                    tourLargeCardList
                    
                    tourSmallCardList
                }
            }
            .background(Color(.systemGray6))
            .navigationDestination(isPresented: $viewModel.showRecomDetail) {
                if let tour = viewModel.selectedTour {
                    DetailView(tour: tour)
                }
            }
            .navigationDestination(isPresented: $viewModel.showDetail) {
                if let tour = viewModel.selectedTour {
                    DetailView(tour: tour)
                }
            }
            .task {
                await viewModel.fetchAllTours()
            }
            .refreshable {
                Task {
                    await viewModel.fetchAllTours()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(Store())
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
                    withAnimation {
                        store.tabSelection = 2
                    }

                } label: {
                    Text("Все")
                        .font(.montserratSemiBold(size: 16))
                        .foregroundStyle(Color.tabColor)
                }
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.tours, id: \.self) { tour in
                        TourLargeCard(tour: tour)
                            .padding(10)
                            .onTapGesture {
                                viewModel.selectedTour = tour
                                viewModel.showRecomDetail.toggle()
                            }
                    }
                }
                .padding(.leading, 10)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
    private var tourSmallCardList: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Можно присоединится")
                    .font(.montserratBold(size: 16))
                    .foregroundStyle(.black)
                
                Spacer()
                
//                Button {
//                    
//                } label: {
//                    Text("Все")
//                        .font(.montserratSemiBold(size: 16))
//                        .foregroundStyle(Color.tabColor)
//                }
            }
            .padding(.horizontal, 20)
            
            LazyVStack(spacing: 20) {
                ForEach(viewModel.tours.reversed(), id: \.self) { tour in
                    TourSmallCard(tour: tour)
                        .onTapGesture {
                            viewModel.selectedTour = tour
                            viewModel.showDetail.toggle()
                        }
                }
            }
        }
    }
}
