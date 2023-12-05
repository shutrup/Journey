import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    let tour: Tour
    
    @State private var isFavorite = true
    @State var selectedImage: String? = nil
    @State var noLimit = Bool()
    @State private var mapCameraPosition: MKCoordinateRegion
    @State private var annotations: [LocationAnnotation] = []
    @State private var selectedIndex: Int = 0
    @State private var routes: [MKRoute] = []
    @StateObject private var locationManagerViewModel = LocationManagerViewModel()
    
    var hours: String {
        let totalHours = tour.duration / 60
        let days = totalHours / 24
        let remainingHours = totalHours % 24
        
        if days > 0 {
            return "\(days) " + pluralForm(n: days, form1: "день", form2: "дня", form5: "дней")
        } else {
            return "\(remainingHours) " + pluralForm(n: remainingHours, form1: "час", form2: "часа", form5: "часов")
        }
    }
    
    var minutes: String {
        let remainingMinutes = tour.duration % 60
        return remainingMinutes > 0 ? "\(remainingMinutes) " + pluralForm(n: remainingMinutes, form1: "минута", form2: "минуты", form5: "минут") : ""
    }
    
    init(tour: Tour) {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: tour.locates.first!.latitude, longitude: tour.locates.first!.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        )
        self._mapCameraPosition = State(initialValue: region)
        self.tour = tour
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                TabView(selection: $selectedIndex) {
                    ForEach(tour.images.indices, id: \.self) { index in
                        WebImage(url: URL(string: tour.images[index])!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.78)
                            .aspectRatio(contentMode: .fill)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.78)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .overlay(alignment: .top) {
                    headerButtonsImage
                }
                .overlay(alignment: .bottom) {
                    footerImagePicker
                }
                
                VStack(spacing: 20) {
                    detailDescription
                    
                    detailDescriptionCards
                    
                    detailOptions
                    
                    description
                    
                    routing
                }
            }
            
            Spacer()
                .frame(height: 100)
        }
        .onAppear {
            self.annotations = createAnnotations(from: tour.locates)
            self.buildRoute()
        }
        .overlay(alignment: .bottom) {
            bottomButtons
        }
        .ignoresSafeArea()
        .onAppear {
            selectedIndex = 0
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DetailView(tour: Tour.FETCH_MOCK)
}

extension DetailView {
    private var headerButtonsImage: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
                    .zIndex(1.0)
                    .overlay {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    }
            }
            
            Spacer()
            
            Button {
                isFavorite.toggle()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)
                    .zIndex(1.0)
                    .overlay {
                        Image(.bookmark)
                            .foregroundStyle(isFavorite ? Color.tabColor : .black)
                    }
                    .animation(.smooth, value: isFavorite)
            }
        }
        .padding(.horizontal)
        .padding(.top, 60)
    }
    private var footerImagePicker: some View {
        HStack(alignment: .top, spacing: 8) {
            ForEach(tour.images.prefix(3).indices, id: \.self) { index in
                WebImage(url: URL(string: tour.images[index]))
                    .resizable()
                    .placeholder {
                        ActivityIndicator(.constant(true))
                            .scaleEffect(1.5)
                    }
                    .frame(width: 54, height: 54)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .clipped()
                    .overlay {
                        if selectedIndex == index {
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color.tabColor, lineWidth: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedIndex = index
                        }
                    }
            }
            
            if tour.images.count > 3 {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.tabColor)
                    .frame(width: 54, height: 54)
                    .overlay {
                        Text("+\(tour.images.count - 3)")
                            .font(.montserratMedium(size: 14))
                            .foregroundColor(.white)
                    }
            }
        }
        .padding(8)
        .frame(height: 70, alignment: .top)
        .background(.white.opacity(0.7))
        .cornerRadius(16)
        .padding(.bottom, 12)
    }
    private var detailDescription: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(alignment: .top) {
                Text(tour.name)
                    .font(.ptSansBold(size: 24))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(tour.categoryIds.name)
                    .font(.ptSansBold(size: 14))
                    .foregroundColor(Color.tabColor)
            }
            
            HStack(spacing: 5) {
                Image(.location)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.tabColor)
                
                Text(tour.place)
                    .font(.ptSansRegular(size: 14))
                    .foregroundStyle(Color.detailGrayColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    private var detailDescriptionCards: some View {
        VStack {
            HStack {
                DetailDescriptionCard(title: "Длительность")
                    .overlay {
                        VStack(spacing: 0) {
                            Text(hours)
                                .font(.ptSansBold(size: 18))
                            
                            if !minutes.isEmpty {
                                Text(minutes)
                                    .font(.ptSansRegular(size: 14))
                            }
                        }
                        .padding(.top)
                    }
                
                Spacer()
                
                DetailDescriptionCard(title: "Мест")
                    .overlay {
                        VStack(spacing: 0) {
                            Text("\(tour.groupSize)")
                                .font(.ptSansBold(size: 18))
                        }
                        .padding(.top)
                    }
                
                Spacer()
                
                DetailDescriptionCard(title: "Рейтинг")
                    .overlay {
                        VStack(spacing: 0) {
                            HStack {
                                Text(String(format: "%.1f", tour.rating))
                                    .font(.ptSansBold(size: 18))
                                
                                Image(.star)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                            }
                            
                            Text("24: отзыва")
                                .font(.ptSansRegular(size: 14))
                                .underline()
                        }
                        .foregroundColor(.black)
                        .padding(.top)
                    }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Место сбор групп")
                        .font(.ptSansRegular(size: 14))
                        .foregroundStyle(Color.detailGrayColor)
                    
                    Text(tour.startCity)
                        .font(.ptSansRegular(size: 16))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Даты набора групп")
                        .font(.ptSansRegular(size: 14))
                        .foregroundStyle(Color.detailGrayColor)
                    
                    Text(tour.startDate)
                        .font(.ptSansRegular(size: 16))
                }
            }
            .padding(.top, 10)
        }
        .padding(.horizontal)
    }
    private var detailOptions: some View {
        VStack(alignment: .leading) {
            Text("Входит в тур")
                .font(.ptSansBold(size: 18))
                .foregroundColor(.black)
            
            ScrollView(.vertical, showsIndicators: false) {
                TagLayout(alignment: .leading, spacing: 10) {
                    ForEach(tour.includedOptionIds, id: \.self) { option in
                        DetailOptionsCell(text: option.name)
                            .padding(.top, 2.5)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    private var description: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Описание")
                .font(.ptSansBold(size: 18))
                .foregroundStyle(.black)
            
            Text(tour.description)
                .font(.ptSansRegular(size: 16))
                .foregroundStyle(Color.detailGrayColor)
                .lineLimit(noLimit ? nil : 6)
                .onTapGesture {
                    withAnimation {
                        noLimit.toggle()
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 0)
    }
    private var routing: some View {
        VStack(alignment: .leading, spacing: 16) {
            let mkAnnotations = annotations.map { location in
                MKPointAnnotation(__coordinate: location.coordinate, title: location.title, subtitle: nil)
            }
            
            Text("Маршрут")
                .font(.ptSansBold(size: 18))
                .foregroundStyle(.black)
            
            MapViewRepresentable(region: locationManagerViewModel.mapRegion ?? mapCameraPosition, annotations: mkAnnotations, routes: routes, coloredRoutes: locationManagerViewModel.coloredRoutes, viewModel: SearchViewModel(tourDataService: TourDataService.tourDataService))
                .onAppear {
                    buildRoute()
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height / 2.12)
                .cornerRadius(24)
                .overlay(alignment: .bottom) {
                    Button {
                        if let currentLocation = locationManagerViewModel.currentLocation {
                            withAnimation {
                                locationManagerViewModel.mapRegion = MKCoordinateRegion(center: currentLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                            }
                            let startLocation = TourLocation(id: "currentLocation", title: "Текущее Местоположение", latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                            let firstDestination = tour.locates.first!
                            createRoute(from: startLocation, to: firstDestination)
                            
                            buildRoute()
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Text("Построить маршрут")
                                .font(.ptSansBold(size: 16))
                                .foregroundColor(.white)
                            
                            Image(.routing)
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 70)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.tabColor)
                        }
                    }
                    .padding(.bottom, 20)
                }
            
        }
        .padding(.horizontal)
        .padding(.top, 0)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var bottomButtons: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Цена:")
                    .font(.ptSansRegular(size: 16))
                    .foregroundStyle(Color.detailGrayColor)
                
                Text("\(tour.pricePerPerson) руб / 1 человек")
                    .font(.ptSansRegular(size: 16))
                    .foregroundStyle(Color.black)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Присоединится")
                    .font(.montserratBold(size: 14))
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 18)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.tabColor)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
        }
    }
}

extension DetailView {
    func pluralForm(n: Int, form1: String, form2: String, form5: String) -> String {
        let n10 = n % 10
        let n100 = n % 100
        
        if n10 == 1 && n100 != 11 {
            return form1
        } else if n10 >= 2 && n10 <= 4 && !(n100 >= 12 && n100 <= 14) {
            return form2
        } else {
            return form5
        }
    }
    func createAnnotations(from locates: [TourLocation]) -> [LocationAnnotation] {
        return locates.map { LocationAnnotation(id: $0.id, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), title: $0.title) }
    }
    func buildRoute() {
        let locations = tour.locates
        guard locations.count > 1 else { return }
        
        for i in 0..<locations.count - 1 {
            let source = locations[i]
            let destination = locations[i + 1]
            createRoute(from: source, to: destination)
        }
    }
    
    func createRoute(from source: TourLocation, to destination: TourLocation) {
        let sourceCoordinate = CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)

        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate {  response, error in
            guard let route = response?.routes.first else { return }
            
            let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple]
            let color = colors[self.locationManagerViewModel.coloredRoutes.count % colors.count]

            let coloredRoute = ColoredRoute(route: route, color: color)
            self.locationManagerViewModel.coloredRoutes.append(coloredRoute)
            self.addRouteToMap(route)
        }
    }

    func addRouteToMap(_ route: MKRoute) {
        routes.append(route)
    }
}
