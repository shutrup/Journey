import SwiftUI
import MapKit
import SDWebImageSwiftUI
import PopupView

struct MapView: View {
    @StateObject private var locationManagerViewModel = LocationManagerViewModel()
    @StateObject var viewModel = SearchViewModel(tourDataService: TourDataService.tourDataService)
    
    var body: some View {
        MapViewRepresentable(
            region: getCurrentRegion(),
            annotations: getCurrentLocationAnnotation() + getTourAnnotations(),
            routes: [],
            coloredRoutes: [], viewModel: viewModel)
        .onAppear {
            locationManagerViewModel.startUpdatingLocation()
        }
        .task {
            await viewModel.fetchAllTours()
        }
        .edgesIgnoringSafeArea(.all)
        .popup(isPresented: $viewModel.isPopupPresented) {
            if let selectedTour = viewModel.selectedTour {
                createPopupContent(for: selectedTour)
            }
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .closeOnTap(false)
                .closeOnTapOutside(true)
        }
        .fullScreenCover(isPresented: $viewModel.showDetail, content: {
            if let selectedTour = viewModel.selectedTour {
                DetailView(tour: selectedTour)
            }
        })
    }
}

#Preview {
    MapView()
}

extension MapView {
    private func getCurrentRegion() -> MKCoordinateRegion {
        if let currentLocation = locationManagerViewModel.currentLocation {
            return MKCoordinateRegion(
                center: currentLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        } else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        }
    }
    
    private func getCurrentLocationAnnotation() -> [MKAnnotation] {
        if let currentLocation = locationManagerViewModel.currentLocation {
            let annotation = MKPointAnnotation()
            annotation.coordinate = currentLocation
            annotation.title = "Я"
            return [annotation]
        }
        return []
    }
    
    private func getTourAnnotations() -> [MKAnnotation] {
        var annotations: [MKAnnotation] = []
        
        for tour in viewModel.tours {
            if let firstLocation = tour.locates.first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: firstLocation.latitude, longitude: firstLocation.longitude)
                annotation.title = tour.name
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
}

extension MapView {
    @ViewBuilder
    private func createPopupContent(for tour: Tour) -> some View {
        VStack(alignment: .leading) {
            if let firstImageUrl = tour.images.first, let url = URL(string: firstImageUrl) {
                HStack {
                    WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 110)
                        .cornerRadius(10)
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading) {
                        Text(tour.name)
                            .font(.headline)

                        Text(tour.categoryIds.name)
                            .font(.subheadline)
                            .padding(.bottom, 5)
                            .foregroundColor(Color.tabColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    viewModel.showDetail.toggle()
                } label: {
                    HStack(spacing: 8) {
                        Text("Посмотреть тур")
                            .font(.ptSansBold(size: 16))
                            .foregroundColor(.white)
                        
                        Image(.routing)
                            .foregroundStyle(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.tabColor)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
