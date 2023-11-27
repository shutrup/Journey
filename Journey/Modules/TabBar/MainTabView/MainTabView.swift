import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        if store.showLogInScreen {
            LoginView()
                .environmentObject(store)
        } else {
            tabBarViews
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(Store())
}

extension MainTabView {
    private var tabBarViews: some View {
        TabView(selection: $store.tabSelection) {
            HomeView()
                .tag(1)
                .environmentObject(store)
            
            SearchView()
                .tag(2)
            
            MapView()
                .tag(3)
            
            ProfileView()
                .environmentObject(store)
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $store.tabSelection)
                .offset(y: 10)
        }
    }
}
