//
//  TrackingView.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 29/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class TrackingView: UIView {
    
    @IBOutlet var mapView: DGSMapView!
    @IBOutlet var userTrackingButton: UserTrackingButton!
    
    weak var delegate: TrackingViewDelegate?
}
