//
//  ToSmrService.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR
import Foundation

extension Service {
    
    static let shared: Service! = {
        return Service(
            clientId: TransportCatcherConfiguration.shared.toSMRClient,
            secret: TransportCatcherConfiguration.shared.toSMRSecret
        )
    }()
}
