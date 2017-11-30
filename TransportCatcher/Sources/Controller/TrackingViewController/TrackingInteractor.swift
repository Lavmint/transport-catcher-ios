//
//  TrackingInteractor.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

class TrackingInteractor {
    
    private(set) var stops: [TransportStop]
    
    init() {
        stops = []
    }
    
    func fetchStops(completion: @escaping () -> Void) {
        Service.shared.stops { [weak self] (box) in
            guard let wself = self else { return }
            switch box.result {
            case .succeed(let stops):
                wself.stops = stops ?? []
            case .error(let error):
                dprint(error.localizedDescription)
            }
            completion()
        }
    }
}
