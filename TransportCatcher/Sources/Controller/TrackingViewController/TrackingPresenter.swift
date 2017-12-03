//
//  TrackingPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit

class TrackingPresenter {
    
    private(set) var interactor: TrackingInteractor
    
    init(interactor: TrackingInteractor) {
        self.interactor = interactor
    }
    
    var stopAnnotations: [StopAnnotation] {
        return interactor.stops.map({ StopAnnotation(stop: $0) })
    }
    
    func imageForStopAnnotationView(transportStop: TransportStop) -> UIImage? {
        guard let tramways = transportStop.tramways, tramways.isEmpty else { return #imageLiteral(resourceName: "ic_stop_tram") }
        guard let trolleybuses = transportStop.trolleybuses, trolleybuses.isEmpty else { return #imageLiteral(resourceName: "ic_stop_trolleybus") }
        return #imageLiteral(resourceName: "ic_stop_bus")
    }
}
