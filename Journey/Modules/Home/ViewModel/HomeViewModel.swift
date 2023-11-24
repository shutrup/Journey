import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var searchText = String()
    @Published var showRecomDetail = Bool()
    @Published var showDetail = Bool()
}
