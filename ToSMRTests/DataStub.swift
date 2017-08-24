//
//  JSONSerializer.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 17/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

final class DataStub {
    
    static var getFirstArrivalToStop: Data {
        return try! Data(contentsOf: Bundle(for: DataStub.self).url(forResource: "getFirstArrivalToStop", withExtension: "json")!)
    }
    
    static var getRouteArrivalToStop: Data {
        return try! Data(contentsOf: Bundle(for: DataStub.self).url(forResource: "getRouteArrivalToStop", withExtension: "json")!)
    }
    
    static var getTransportsOnRoute: Data {
        return try! Data(contentsOf: Bundle(for: DataStub.self).url(forResource: "getTransportsOnRoute", withExtension: "json")!)
    }
    
    static var getSurroundingTransports: Data {
        return try! Data(contentsOf: Bundle(for: DataStub.self).url(forResource: "getSurroundingTransports", withExtension: "json")!)
    }
}
