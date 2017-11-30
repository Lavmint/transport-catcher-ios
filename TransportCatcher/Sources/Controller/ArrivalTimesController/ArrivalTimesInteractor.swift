//
//  ArrivalTimesInteractor.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

class ArrivalTimesInteractor {
    
    private(set) var arrivals: [Arrival]
    
    init() {
        arrivals = []
    }
    
    func fetchArrivals(toStopId stopId: Int, completion: @escaping () -> Void) {
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self, stopId == stopId else { return }
            switch box.result {
            case .succeed(let arrivals):
                wself.arrivals = arrivals ?? []
            case .error(let error):
                dprint(error.localizedDescription)
            }
            completion()
        }
    }
}
