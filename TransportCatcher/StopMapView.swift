//
//  StopMapView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 16/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit

internal class StopMapView: UIView, NibLoadableView {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    var mapViewOverlay: MKTileOverlay!
    
    func configure() {
        
        mapView.showsCompass = false
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.showsPointsOfInterest = false
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        
        mapViewOverlay = DGSTileOverlay()
        mapView.insert(mapViewOverlay, at: 0, level: .aboveLabels)
        
        let center = CLLocationCoordinate2D(latitude: 53.220841596277012, longitude: 50.170634245448952)
        let span = MKCoordinateSpan(latitudeDelta: 0.11244419438441611, longitudeDelta: 0.16504663881798365)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
}
