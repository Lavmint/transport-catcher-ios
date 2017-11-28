//
//  StopMapViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR
import MapKit

internal class TransportStopMapViewController: DGSMapViewController {
    
    override var nibName: String? {
        return String.init(describing: DGSMapViewController.self)
    }
    
    var delegate: TransportStopMapViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        reloadData()
    }
    
    func reloadData() {
        mapView.configure()
        Service.shared.stops { [weak self] (box) in
            guard let wself = self else { return }
            switch box.result {
            case .succeed(let stops):
                guard let unwrappedStops = stops else { return }
                let annotations: [TransportStopAnnotation] = unwrappedStops.map({ TransportStopAnnotation(stop: $0) })
                wself.mapView.addAnnotations(annotations)
            case .error(let error):
                let alert = UIAlertController.singleActionAlert(aTitle: "OK", message: error.localizedDescription)
                wself.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension TransportStopMapViewController: MKMapViewDelegate {
    
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
        delegate?.mapView(mapView as! DGSMapView, didSelect: transportAnnotation.stop.id)
    }
}
