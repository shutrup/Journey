import Foundation
import CoreLocation
import MapKit

class LocationManagerViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapRegion: MKCoordinateRegion?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var coloredRoutes: [ColoredRoute] = []
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
