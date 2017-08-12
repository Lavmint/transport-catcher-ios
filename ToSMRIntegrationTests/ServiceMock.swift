//
//  ServiceMock.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

internal final class ServiceMock {
    
    static let shared: Service? = {
        guard let infoDictionary = Bundle(for: ServiceMock.self).infoDictionary else {
            return nil
        }
        guard let clientId = infoDictionary["clientId"] as? String, let secret = infoDictionary["secret"] as? String else {
            return nil
        }
        return Service(clientId: clientId, secret: secret)
    }()
}
