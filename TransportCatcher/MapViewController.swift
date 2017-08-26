//
//  ViewController.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/06/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    private let tilesOverlay = DGSTileOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.showsCompass = false
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.showsPointsOfInterest = false
        mapView.showsBuildings = false
        mapView.showsTraffic = false
        
        mapView.insert(tilesOverlay, at: 0, level: .aboveLabels)
        mapView.delegate = self
        
        //center%2F50.184345%2C53.214103%2Fzoom%2F13
        let center = CLLocationCoordinate2D(latitude: 53.220841596277012, longitude: 50.170634245448952)
        let span = MKCoordinateSpan(latitudeDelta: 0.11244419438441611, longitudeDelta: 0.16504663881798365)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
    
    // MARK: MKMapViewDelegate
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return MKTileOverlayRenderer(overlay: overlay)
    }
}

