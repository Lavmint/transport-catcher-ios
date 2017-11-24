//
//  TransportCatcherConfiguration.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/09/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

final class TransportCatcherConfiguration {
    
    static let shared: TransportCatcherConfiguration = {
        let dict = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "TransportCatcher-Info", ofType: "plist")!) as! [String: Any]
        var configuration = TransportCatcherConfiguration()
        configuration.toSMRClient = dict["TC_TOSMR_CLIENT"] as! String
        configuration.toSMRSecret = dict["TC_TOSMR_SECRET"] as! String
        return configuration
    }()
    
    private(set) var toSMRClient: String!
    private(set) var toSMRSecret: String!
}
