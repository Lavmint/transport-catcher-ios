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

protocol TrackingViewControllerDelegate: class {
    func willFetchStops(trackingViewController: TrackingViewController)
    func didFetchStops(trackingViewController: TrackingViewController)
    func willRequestLocation(trackingViewController: TrackingViewController)
    func didReceiveLocation(trackingViewController: TrackingViewController)
}

class TrackingViewController: UIViewController, GenericView {

    typealias View = TrackingView
    private(set) var locationManager: CLLocationManager!
    private(set) var presenter: TrackingPresenter!
    private(set) var interactor: TrackingInteractor!
    weak var delegate: TrackingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        interactor = TrackingInteractor()
        presenter = TrackingPresenter(interactor: interactor)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        genericView.mapView.delegate = self
        genericView.mapView.loadDGSLayer()
        reload()
    }
    
    func reload() {
        delegate?.willFetchStops(trackingViewController: self)
        interactor.fetchStops { [weak self] (throwError) in
            guard let wself = self else { return }
            defer {
                wself.delegate?.didFetchStops(trackingViewController: wself)
            }
            do {
                try throwError()
            } catch {
                AlertHelper.presentInfoAlert(.OK, message: error.localizedDescription, on: wself)
                return
            }
            wself.genericView.mapView.addAnnotations(wself.presenter.stopAnnotations)
        }
    }
    
    @IBAction func onRequestLocationTapped(_ sender: UIButton) {
        delegate?.willRequestLocation(trackingViewController: self)
        locationManager.requestLocation()
    }

}

extension TrackingViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer {
            delegate?.didReceiveLocation(trackingViewController: self)
        }
        guard let location = locations.first?.coordinate else { return }
        genericView.mapView.setAdjustedRegion(center: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlertHelper.presentInfoAlert(.OK, message: error.localizedDescription, on: self)
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
    
    func view(forTransportAnnotation annotation: StopAnnotation, mapView: MKMapView) -> TransportStopAnnotationView {
        var view: TransportStopAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: TransportStopAnnotationView.stringClass) as? TransportStopAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = TransportStopAnnotationView(annotation: annotation, reuseIdentifier: TransportStopAnnotationView.stringClass)
        }
        view.image = presenter.imageForStopAnnotationView(transportStop: annotation.stop)
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let transportAnnotation = view.annotation as? StopAnnotation else { return }
        genericView.delegate?.trackingView(genericView, didSelect: Int(transportAnnotation.stop.id))
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        AlertHelper.presentInfoAlert(.OK, message: error.localizedDescription, on: self)
    }
}
