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
    private(set) var selectedStop: Int?
    
    init() {
        arrivals = []
    }
    
    func fetchArrivals(toStopId stopId: Int, completion: @escaping (() throws -> Void) -> Void) {
        selectedStop = stopId
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self else { return }
            var callbackError: Error? = nil
            defer {
                completion({
                    if let error = callbackError {
                        throw error
                    }
                    return
                })
            }
            guard stopId == wself.selectedStop else { return }
            switch box.result {
            case .succeed(let arrivals):
                wself.arrivals = arrivals ?? []
            case .error(let error):
                dprint(error.localizedDescription)
                callbackError = error
            }
        }
    }
}
