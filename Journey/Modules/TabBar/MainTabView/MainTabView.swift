import SwiftUI

struct MainTabView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeView()
                .tag(1)
            
            SearchView()
                .tag(2)
            
            MapView()
                .tag(3)
            
            Text("Profile")
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
                .offset(y: 10)
        }
    }
}

#Preview {
    MainTabView()
}
