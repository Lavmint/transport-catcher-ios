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
    private let classifierFetcher: ClassifierFetcher
    private let transportStopStorage: TransportStopStorage
    
    init() {
        stops = []
        classifierFetcher = ClassifierFetcher()
        self.transportStopStorage = TransportStopStorage(context: ClassifierPersistenseContainer.shared.viewContext)
    }
    
    func fetchStops(completion: @escaping (Error?) -> Void) {
        classifierFetcher.fetchStops(completion: { (error) in
            self.stops = self.transportStopStorage.all
            completion(error)
        })
    }
}
