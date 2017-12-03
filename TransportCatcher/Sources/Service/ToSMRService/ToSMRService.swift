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
        guard let client = Bundle.main.appInfoDictionary?["TC_TOSMR_CLIENT"] as? String else { return nil }
        guard let secret = Bundle.main.appInfoDictionary?["TC_TOSMR_SECRET"] as? String else { return nil }
        return Service(clientId: client, secret: secret)
    }()
}
