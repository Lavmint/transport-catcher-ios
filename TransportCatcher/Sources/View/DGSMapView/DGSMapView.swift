//
//  StopMapView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 16/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import MapKit

internal class DGSMapView: MKMapView {
    
    private(set) var mapViewOverlay: MKTileOverlay!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        
        self.showsCompass = false
        self.showsCompass = true
        self.showsUserLocation = true
        self.mapType = .standard
        self.showsPointsOfInterest = false
        self.showsBuildings = false
        self.showsTraffic = false
        
        self.mapViewOverlay = DGSTileOverlay()
        self.insert(mapViewOverlay, at: 0, level: .aboveLabels)
        
        let center = CLLocationCoordinate2D(latitude: 53.220841596277012, longitude: 50.170634245448952)
        let region = MKCoordinateRegionMakeWithDistance(center, 5000, 5000)
        let adjustedRegion = self.regionThatFits(region)
        self.setRegion(adjustedRegion, animated: true)
    }
}
