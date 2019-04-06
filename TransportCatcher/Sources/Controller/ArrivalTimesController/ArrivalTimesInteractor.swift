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
    
    func fetchArrivals(toStopId stopId: Int, completion: @escaping (Error?) -> Void) {
        selectedStop = stopId
        Service.shared.approximateArrivals(toStop: stopId) { [weak self] (box) in
            guard let wself = self else { return }
            var callbackError: Error? = nil
            defer {
                completion(callbackError)
            }
            guard stopId == wself.selectedStop else { return }
            switch box.result {
            case .success(let arrivals):
                wself.arrivals = arrivals ?? []
            case .failure(let error):
                dprint(error.localizedDescription)
                callbackError = error
            }
        }
    }
}
