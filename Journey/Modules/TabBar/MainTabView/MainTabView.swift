import SwiftUI

struct MainTabView: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Text("Home")
                .tag(1)
            
            Text("Search")
                .tag(2)
            
            Text("Map")
                .tag(3)
            
            Text("Profile")
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabView(tabSelection: $tabSelection)
        }
    }
}

#Preview {
    MainTabView()
}