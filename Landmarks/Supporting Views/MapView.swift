import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        view.mapType = MKMapType.standard // (satellite)
        
//        var locationCoordinate: CLLocationCoordinate2D {
//            CLLocationCoordinate2D(
//                latitude: coordinates.latitude,// - 00.003,
//                longitude: coordinates.longitude)// + 00.01)

        
        
        let centerCoordinate =  CLLocationCoordinate2D(latitude:coordinate.latitude - 00.0025 ,longitude:coordinate.longitude + 00.006)
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        view.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
//        annotation.title = "My Location"
//        annotation.subtitle = "Visit us soon"
        view.addAnnotation(annotation)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
                MapView(coordinate:        CLLocationCoordinate2D(
                    latitude :  56.911541,
                    longitude: 60.806326))
    }
}
