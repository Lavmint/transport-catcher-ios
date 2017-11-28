//
//  TransportStopMapViewDelegate.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

protocol TransportStopMapViewDelegate: class {
    func mapView(_ mapView: DGSMapView, didSelect stopId: Int)
}

