import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var manager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView()
}
