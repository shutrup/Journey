import SwiftUI

final class Store: ObservableObject {
    @Published var tabSelection = 1
    @AppStorage("showLogInScreen") var showLogInScreen = true
    @AppStorage("isAuth") var isAuth = true
    @AppStorage("userId") var userId = String()
}
