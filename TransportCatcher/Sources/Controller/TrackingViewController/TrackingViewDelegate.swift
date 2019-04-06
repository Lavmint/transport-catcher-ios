//
//  TrackingMapViewDelegate.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

protocol TrackingViewDelegate: class {
    func trackingView(_ trackingView: TrackingView, didSelect stopId: Int)
}
