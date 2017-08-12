//
//  ClientStub.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

final class ClientStub {
    let clientId: String
    let secret: String
    
    init?() {
        guard let infoDictionary = Bundle(for: ClientStub.self).infoDictionary else {
            return nil
        }
        guard let clientId = infoDictionary["clientId"] as? String, let secret = infoDictionary["secret"] as? String else {
            return nil
        }
        self.clientId = clientId
        self.secret = secret
    }
}
