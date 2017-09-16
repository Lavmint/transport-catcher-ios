//
//  TransportStop.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR
import MapKit

final class TransportStopAnnotation: NSObject, MKAnnotation {
    
    let stop: TransportStop
    
    init(stop: TransportStop) {
        self.stop = stop
    }
    
    public var title: String? {
        return stop.name
    }
    
    public var subtitle: String? {
        return nil
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: stop.latitude , longitude: stop.longitude)
    }
}
