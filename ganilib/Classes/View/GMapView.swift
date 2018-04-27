import UIKit
import MapKit

open class GMapView: MKMapView {
    private var helper: ViewHelper!
    private let locationManager = CLLocationManager()
    private var onUserLocationUpdate: ((GMapView) -> Void)?
    
    fileprivate var previousLocation = CLLocation(latitude: 0, longitude: 0)
    fileprivate var calloutPin = false
    fileprivate var direction = false
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        self.delegate = self
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func color(bg : UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
        return self
    }
    
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }
    
    open func onUserLocationUpdate(_ command: @escaping (GMapView) -> Void) -> Self {
        self.onUserLocationUpdate = command
        return self
    }
    
    public func trackUser() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            self.showsUserLocation = true
            self.userTrackingMode = .followWithHeading
        } else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
    }

    public func end() {
        // Ends chaining
    }
}

extension GMapView: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .denied) {
            // The user denied authorization
        } else if (status == .authorizedWhenInUse) {
            self.showsUserLocation = true
            self.userTrackingMode = .followWithHeading
        }
    }
}

extension GMapView: MKMapViewDelegate {
    
    // MARK: Callback
    
    public func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let distance = currentLocation.distance(from: previousLocation)
        
        // Only update when location has changed significantly, particularly because this method gets executed whenever
        // the device is rotated.
        if distance > 10 {  // 10 meters
            GLog.i("User location updated: \(userLocation.coordinate)")
            if let handler = self.onUserLocationUpdate {
                handler(self)
            }
        }
        
        self.previousLocation = currentLocation
    }
    
    
    
    // MARK: Directions

    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = UIColor.blue
            return renderer
        }

        return MKOverlayRenderer()
    }
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if !direction {
            return
        }
        
        if view.isKind(of: MKUserLocation.self) {
            return
        }

        if view.isKind(of: MKPinAnnotationView.self) {
            mapView.removeOverlays(mapView.overlays)

            let request = MKDirectionsRequest()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))

            let directions = MKDirections(request: request)
            directions.calculate(completionHandler: { (response, error) in
                guard let unwrappedResponse = response else { return }

                for route in unwrappedResponse.routes {
                    self.add(route.polyline)
                    self.setVisibleMapRect(route.polyline.boundingMapRect,
                                                   edgePadding: UIEdgeInsetsMake(20, 20, 20, 20),
                                                   animated: true)
                }
            })
        }
    }
    
    
    
    // MARK: Callout Pin
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !calloutPin {
            return nil
        }
        
        let identifier = "MyPin"

        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        let view: MKPinAnnotationView
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            view = annotationView
            
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let subtitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            subtitle.text = annotation.subtitle ?? ""
            subtitle.numberOfLines = 0
            view.detailCalloutAccessoryView = subtitle;
        }
        else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        return view
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation
        if let coordinate = annotation?.coordinate {
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            if let title = annotation?.title {
                mapItem.name = title
            }
            mapItem.openInMaps(launchOptions: nil)
        }
    }
}

public class GPointAnnotation: MKPointAnnotation {
    public func coordinate(_ coordinate: CLLocationCoordinate2D) -> Self {
        self.coordinate = coordinate
        return self
    }
    
    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    public func subtitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle
        return self
    }
}
