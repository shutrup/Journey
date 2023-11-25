import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    let tourDataService: TourDataServiceProtocol
    
    init(tourDataService: TourDataServiceProtocol) {
        self.tourDataService = tourDataService
    }
    
    @Published var searchText = String()
    @Published var showRecomDetail = Bool()
    @Published var showDetail = Bool()
    @Published var tours = [Tour]()
    @Published var selectedTour: Tour? = nil
    
    func fetchAllTours() async {
        let result = await tourDataService.fetch()
        
        switch result {
        case .success(let data):
            self.tours = data
        case .failure(let error):
            print(error)
        }
    }
}
