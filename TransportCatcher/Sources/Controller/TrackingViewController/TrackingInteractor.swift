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
    
    func fetchStops(completion: @escaping (() throws -> Void) -> Void) {
        classifierFetcher.fetchStops(completion: { [weak self] (throwError) in
            guard let wself = self else { return }
            do {
                try throwError()
                wself.stops = wself.transportStopStorage.all
                completion { return }
            } catch {
                completion { throw error }
            }
        })
    }
}
