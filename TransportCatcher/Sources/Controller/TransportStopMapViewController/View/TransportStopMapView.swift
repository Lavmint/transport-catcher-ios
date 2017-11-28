//
//  StopMapView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit

class TransportStopMapView: DGSMapView {
    
    weak var stopMapViewDelegate: TransportStopMapViewDelegate?
    private(set) var locationManager: CLLocationManager
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        self.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setRegion(location: locationManager.location)
    }
}

extension TransportStopMapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is TransportStopAnnotation:
            return view(forTransportAnnotation: annotation as! TransportStopAnnotation, mapView: mapView)
        default:
            return nil
        }
    }
    
    func view(forTransportAnnotation annotation: TransportStopAnnotation, mapView: MKMapView) -> MKAnnotationView {
        
        let identifier = String(annotation.stop.id)
        var view: MKAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.image = #imageLiteral(resourceName: "ic_stop")
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let transportAnnotation = view.annotation as? TransportStopAnnotation else { return }
        stopMapViewDelegate?.mapView(self, didSelect: transportAnnotation.stop.id)
    }
}

extension TransportStopMapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setRegion(location: locations.first)
    }
    
    func setRegion(location: CLLocation?) {
        guard let location = location else { return }
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        let adjustedRegion = self.regionThatFits(region)
        self.setRegion(adjustedRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dprint(error)
    }
}
