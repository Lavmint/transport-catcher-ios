//
//  TransportStop.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import MapKit

final class StopAnnotation: NSObject, MKAnnotation {
    
    let stop: TransportStop
    
    init(stop: TransportStop) {
        self.stop = stop
    }
    
    public var title: String? {
        return stop.localizedName
    }
    
    public var subtitle: String? {
        return [stop.localizedAdjacentStreet ?? "", stop.localizedDirection ?? ""].joined(separator: " ")
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: stop.latitude , longitude: stop.longitude)
    }
}
