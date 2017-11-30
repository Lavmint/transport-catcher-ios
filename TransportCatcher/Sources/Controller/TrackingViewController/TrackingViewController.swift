//
//  TrackingMapViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TrackingViewController: UIViewController, GenericView {

    typealias View = TrackingView
    private(set) var locationManager: CLLocationManager!
    private(set) var presenter: TrackingPresenter!
    private(set) var interactor: TrackingInteractor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        interactor = TrackingInteractor()
        presenter = TrackingPresenter(interactor: interactor)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        genericView.mapView.delegate = self
        genericView.mapView.loadDGSLayer()
        reload()
    }
    
    func reload() {
        interactor.fetchStops { [weak self] in
            guard let wself = self else { return }
            wself.genericView.mapView.addAnnotations(wself.presenter.stopAnnotations)
        }
    }
    
    @IBAction func onRequestLocationTapped(_ sender: UIButton) {
        locationManager.requestLocation()
    }

}

extension TrackingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        genericView.mapView.setAdjustedRegion(center: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dprint(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            genericView.userTrackingButton.isHidden = false
        default:
            genericView.userTrackingButton.isHidden = true
        }
    }
}

extension TrackingViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is StopAnnotation:
            return view(forTransportAnnotation: annotation as! StopAnnotation, mapView: mapView)
        default:
            return nil
        }
    }
    
    func view(forTransportAnnotation annotation: StopAnnotation, mapView: MKMapView) -> MKAnnotationView {
        
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
        guard let transportAnnotation = view.annotation as? StopAnnotation else { return }
        genericView.delegate?.trackingView(genericView, didSelect: transportAnnotation.stop.id)
    }
}
