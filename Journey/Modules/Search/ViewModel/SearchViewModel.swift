import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    let tourDataService: TourDataServiceProtocol
    
    init(tourDataService: TourDataServiceProtocol) {
        self.tourDataService = tourDataService
    }
    
    @Published var searchText = String()
    @Published var selectedCategories: [Category] = []
    @Published var showFilter = Bool()
    
    @Published var showDetail = Bool()
    
    @Published var tours = [Tour]()
    @Published var categories = [Category]()
    
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
    
    func fetchAllCategories() async {
        let result = await tourDataService.fetchCategories()
        
        switch result {
        case .success(let data):
            self.categories = data
        case .failure(let error):
            print(error)
        }
    }
}
