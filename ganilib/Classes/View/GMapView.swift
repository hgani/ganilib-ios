import MapKit
import UIKit

open class GMapView: MKMapView {
    private var helper: ViewHelper!
    private let locationManager = CLLocationManager()
    private var onUserLocationUpdate: ((GMapView, MKUserLocation) -> Void)?

    fileprivate var previousLocation = CLLocation(latitude: 0, longitude: 0)
    fileprivate var calloutPin = false
    fileprivate var direction = false

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)
        delegate = self
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
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

    open func onUserLocationUpdate(_ command: @escaping (GMapView, MKUserLocation) -> Void) -> Self {
        onUserLocationUpdate = command
        return self
    }

    public func trackUser() -> Self {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            showsUserLocation = true
            userTrackingMode = .followWithHeading
        } else {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }
        return self
    }

    public func end() {
        // Ends chaining
    }
}

extension GMapView: CLLocationManagerDelegate {
    public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            // The user denied authorization
        } else if status == .authorizedWhenInUse {
            showsUserLocation = true
            userTrackingMode = .followWithHeading
        }
    }
}

extension GMapView: MKMapViewDelegate {
    // MARK: Callback

    public func mapView(_: MKMapView, didUpdate userLocation: MKUserLocation) {
        let currentLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let distance = currentLocation.distance(from: previousLocation)

        // Only update when location has changed significantly, particularly because this method gets executed whenever
        // the device is rotated.
        if distance > 10 { // 10 meters
            GLog.i("User location updated: \(userLocation.coordinate)")
            onUserLocationUpdate?(self, userLocation)
        }

        previousLocation = currentLocation
    }

    // MARK: Directions

    public func mapView(_: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Render routing
        if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = UIColor.blue
            return renderer
        }

        return MKOverlayRenderer()
    }

    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? GPointAnnotation {
            annotation.performClick()
        }

        if !direction {
            return
        }

        if view.isKind(of: MKUserLocation.self) {
            return
        }

        let defaultPin: Bool
        if #available(iOS 11.0, *) {
            defaultPin = view.isKind(of: MKMarkerAnnotationView.self)
        } else {
            defaultPin = false
        }

        if defaultPin || view.isKind(of: MKPinAnnotationView.self) {
            mapView.removeOverlays(mapView.overlays)

            let request = MKDirectionsRequest()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: view.annotation!.coordinate))

            let directions = MKDirections(request: request)
            directions.calculate(completionHandler: { response, _ in
                guard let unwrappedResponse = response else { return }

                for route in unwrappedResponse.routes {
                    self.add(route.polyline)
                    self.setVisibleMapRect(route.polyline.boundingMapRect,
                                           edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
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

        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        let identifier = "MyPin"
        let view: MKPinAnnotationView
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            view = annotationView

            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            let subtitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            subtitle.text = annotation.subtitle ?? ""
            subtitle.numberOfLines = 0
            view.detailCalloutAccessoryView = subtitle
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        return view
    }

    public func mapView(_: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped _: UIControl) {
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
    private var onClick: ((GPointAnnotation) -> Void)?

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

    public func onClick(_ command: @escaping (GPointAnnotation) -> Void) -> Self {
        onClick = command
        return self
    }

    public func performClick() {
        onClick?(self)
    }
}
