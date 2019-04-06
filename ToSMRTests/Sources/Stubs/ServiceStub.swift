//
//  ClientStub.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

final class ServiceStub {
    
    static let shared: Service! = {
        guard let infoDictionary = Bundle(for: ServiceStub.self).infoDictionary else {
            return nil
        }
        guard let clientId = infoDictionary["clientId"] as? String, let secret = infoDictionary["secret"] as? String else {
            return nil
        }
        return Service(clientId: clientId, secret: secret)
    }()
    
}
