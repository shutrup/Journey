import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    let tourDataService: TourDataServiceProtocol
    
    init(tourDataService: TourDataServiceProtocol) {
        self.tourDataService = tourDataService
    }
    
    @Published var searchText = String()
    @Published var categories: [String] = ["Пейзажи","Горы","Водоемы","Что то","Кто то"]
    @Published var selectedCategories: [String] = []
    @Published var showFilter = Bool()
    
    @Published var showDetail = Bool()
    
    @Published var tours = [Tour]()
    
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
