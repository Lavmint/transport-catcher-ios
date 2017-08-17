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
}
