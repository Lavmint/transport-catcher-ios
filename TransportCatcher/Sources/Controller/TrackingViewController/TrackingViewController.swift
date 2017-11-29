//
//  TrackingMapViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR
import CoreLocation

class TrackingViewController: UIViewController, GenericView {

    typealias View = TrackingView
    private(set) var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        genericView.mapView.loadDGSLayer()
        reload()
    }
    
    func reload() {
        Service.shared.stops { [weak self] (box) in
            guard let wself = self else { return }
            switch box.result {
            case .succeed(let stops):
                guard let unwrappedStops = stops else { return }
                let annotations: [StopAnnotation] = unwrappedStops.map({ StopAnnotation(stop: $0) })
                wself.genericView.mapView.addAnnotations(annotations)
            case .error(let error):
                let alert = UIAlertController.singleActionAlert(aTitle: LocalizedString.Alert.OK, message: error.localizedDescription)
                wself.present(alert, animated: true, completion: nil)
            }
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

