import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    let tourDataService: TourDataServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(tourDataService: TourDataServiceProtocol) {
        self.tourDataService = tourDataService
        Task {
            await fetchAllCategories()
        }
        setupSearchSubscription()
    }
    
    @Published var hasSetInitialRegion = false
    @Published var isSearchPerformed = false
    @Published var searchText = String()
    @Published var selectedCategory: Category? = nil
    @Published var showFilter = Bool()
    @Published var showDetail = Bool()
    @Published var tours = [Tour]()
    @Published var categories = [Category]()
    @Published var selectedTour: Tour? = nil
    {
        didSet {
            isPopupPresented = selectedTour != nil
        }
    }
    @Published var isPopupPresented = false
    
    
    func fetchAllTours() async {
        let result = await tourDataService.fetch()
        
        switch result {
        case .success(let data):
            withAnimation(.bouncy) {
                self.tours = data
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchByCategory(id: String) async {
        let result = await tourDataService.fetchByCategory(id: id)
        
        switch result {
        case .success(let data):
            withAnimation(.bouncy) {
                self.tours = data
            }
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
    
    func filter(startDate: String?, endDate: String?, minPrice: String?, maxPrice: String?, startCity: String?, groupSize: String?) async {
        let result = await tourDataService.filter(startDate: startDate, endDate: endDate, minPrice: minPrice, maxPrice: maxPrice, startCity: startCity, groupSize: groupSize)
        
        switch result {
        case .success(let data):
            withAnimation {
                self.tours = data
            }
        case .failure(let error):
            print(error)
        }
    }
    
    private func setupSearchSubscription() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [weak self] searchText in
                self?.searchToursPublisher(title: searchText) ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] tours in
                withAnimation {
                    self?.tours = tours
                }
            })
            .store(in: &cancellables)
    }
    
    private func searchToursPublisher(title: String) -> AnyPublisher<[Tour], Error> {
        if title.isEmpty {
            return Future { [weak self] promise in
                Task {
                    await self?.fetchAllTours()
                    promise(.success(self?.tours ?? []))
                }
            }
            .eraseToAnyPublisher()
        } else {
            return Future { [weak self] promise in
                Task {
                    let result = await self?.tourDataService.search(title: title)
                    switch result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    case .none:
                        break
                    }
                }
            }
            .eraseToAnyPublisher()
        }
    }
}
