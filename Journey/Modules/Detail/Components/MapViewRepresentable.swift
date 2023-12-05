import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    var region: MKCoordinateRegion
    var annotations: [MKAnnotation]
    var routes: [MKRoute]
    var coloredRoutes: [ColoredRoute]
    var viewModel: SearchViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
//        if !context.coordinator.parent.viewModel.hasSetInitialRegion {
        uiView.setRegion(region, animated: true)
//            context.coordinator.parent.viewModel.hasSetInitialRegion = true
//        }
        uiView.addAnnotations(annotations)
        uiView.removeOverlays(uiView.overlays)
        
        context.coordinator.coloredRoutes = coloredRoutes
        
        for coloredRoute in coloredRoutes {
            uiView.addOverlay(coloredRoute.route.polyline)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, coloredRoutes: coloredRoutes, viewModel: viewModel)
    }
}


extension MapViewRepresentable {
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRepresentable
        var coloredRoutes: [ColoredRoute]
        var viewModel: SearchViewModel
        
        init(parent: MapViewRepresentable, coloredRoutes: [ColoredRoute], viewModel: SearchViewModel) {
            self.parent = parent
            self.coloredRoutes = coloredRoutes
            self.viewModel = viewModel
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                if let coloredRoute = coloredRoutes.first(where: { $0.route.polyline === polyline }) {
                    renderer.strokeColor = coloredRoute.color
                } else {
                    renderer.strokeColor = .blue
                }
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        @MainActor func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let title = view.annotation?.title as? String {
                let selected = viewModel.tours.first { $0.name == title }
                viewModel.selectedTour = selected
            }
        }
    }
}

