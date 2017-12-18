//
//  Arrival.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 18/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

extension Arrival {
    
    var localizedType: String {
        switch type {
        case .bus:
            return LocalizedString.Transport.bus
        case .tramway:
            return LocalizedString.Transport.tramway
        case .trolleybus:
            return LocalizedString.Transport.trolleybus
        }
    }
}
