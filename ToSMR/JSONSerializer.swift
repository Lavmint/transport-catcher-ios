//
//  JSONSerializer.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

final internal class JSONSerializer: Serializer {
    
    internal func data<T>(from object: T?) -> Data? {
        return nil
    }
}

// MARK: Deserialization
internal extension JSONSerializer {
 
    internal func object<T>(from data: Data?) -> T? {
        
        guard let data = data else {
            return nil
        }
        
        do {
            if T.self == [Arrival].self { return try arrivals(from: data) as! T? }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    internal func arrivals(from data: Data) throws -> [Arrival]? {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        let dictionary: [String: Any] = try (jsonObject as? [String: Any]).required()
        let rawArrivals: [[String: Any]] = try dictionary.castable(requiredField: "arrival")
        
        var arrivals: [Arrival] = []
        for rawArrival in rawArrivals {
            let transport = Transport(
                type: try rawArrival.enumeration(requiredField: "type"),
                number: try rawArrival.castable(requiredField: "number"),
                route: try rawArrival.parsable(requiredField: "KR_ID"),
                hullNumber: try rawArrival.parsable(requiredField: "hullNo"),
                stateNumber: try rawArrival.castable(requiredField: "stateNumber"),
                model: try rawArrival.castable(optionalField: "modelTitle"),
                isInvalidFriendly: try rawArrival.parsable(requiredField: "forInvalid")
            )
            let arrival = Arrival(
                transport: transport,
                time: try rawArrival.parsable(requiredField: "time"),
                timeInSeconds: try rawArrival.parsable(requiredField: "timeInSeconds"),
                nextStopName: try rawArrival.castable(requiredField: "nextStopName"),
                remainingLength: try rawArrival.parsable(requiredField: "remainingLength"),
                spanLength: try rawArrival.parsable(requiredField: "spanLength"),
                requestedStopId: try rawArrival.parsable(requiredField: "requestedStopId")
            )
            arrivals.append(arrival)
        }
        
        return arrivals
    }
}
