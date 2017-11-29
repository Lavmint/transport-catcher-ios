//
//  TrackingMapViewDelegate.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

protocol TrackingMapViewDelegate: class {
    func trackingMapView(_ trackingMapView: TrackingMapView, didSelect stopId: Int)
}
