//
//  ToSMRService.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 26/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

extension Service {
    
    static let shared: Service! = {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            return nil
        }
        guard let clientId = infoDictionary["clientId"] as? String, let secret = infoDictionary["secret"] as? String else {
            return nil
        }
        return Service(clientId: clientId, secret: secret)
    }()
}
