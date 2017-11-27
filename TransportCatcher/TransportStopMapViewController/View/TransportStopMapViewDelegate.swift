//
//  StopMapViewDelegate.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 27/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

protocol TransportStopMapViewDelegate: class {
    func mapView(_ stopMapView: TransportStopMapView, didSelect stopId: Int)
}
