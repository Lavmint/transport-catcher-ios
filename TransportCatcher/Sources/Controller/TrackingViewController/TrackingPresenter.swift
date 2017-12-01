//
//  TrackingPresenter.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import UIKit
import ToSMR

class TrackingPresenter {
    
    private(set) var interactor: TrackingInteractor
    
    init(interactor: TrackingInteractor) {
        self.interactor = interactor
    }
    
    var stopAnnotations: [StopAnnotation] {
        return interactor.stops.map({ StopAnnotation(stop: $0) })
    }
    
    func imageForStopAnnotationView(transportStop: ToSMR.TransportStop) -> UIImage? {
        guard transportStop.tramways.isEmpty else { return #imageLiteral(resourceName: "ic_stop_tram") }
        guard transportStop.trolleybuses.isEmpty else { return #imageLiteral(resourceName: "ic_stop_trolleybus") }
        return #imageLiteral(resourceName: "ic_stop_bus")
    }
}
