//
//  DGSMapViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DGSMapViewController: UIViewController {

    @IBOutlet var mapView: DGSMapView!
    @IBOutlet var userTrackingButton: DGSUserTrackingButton!
    private(set) var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func onUserTrackingButtonTapped(_ sender: DGSUserTrackingButton) {
        locationManager.requestLocation()
    }
}

extension DGSMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setRegion(location: locations.first)
    }
    
    func setRegion(location: CLLocation?) {
        guard let location = location else { return }
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        let adjustedRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dprint(error)
    }
}
