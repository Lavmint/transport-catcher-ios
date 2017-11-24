//
//  StopMapViewMKMapViewDelegate.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import MapKit
import ToSMR

internal class StopMapViewDelegate: NSObject, MKMapViewDelegate {
    
    var didSelectStop: ((Int) -> Void)?

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
        didSelectStop?(transportAnnotation.stop.id)
    }
}
