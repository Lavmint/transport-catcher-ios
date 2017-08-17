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
        let rawArrivals: [[String: Any]] = try dictionary.castable(required: "arrival")
        
        var arrivals: [Arrival] = []
        for rawArrival in rawArrivals {
            let transport = Transport(
                type: try rawArrival.enumeration(required: "type"),
                number: try rawArrival.castable(required: "number"),
                route: try rawArrival.parsable(required: "KR_ID"),
                hullNumber: try rawArrival.parsable(required: "hullNo"),
                stateNumber: try rawArrival.castable(required: "stateNumber"),
                model: try rawArrival.castable(optional: "modelTitle"),
                isInvalidFriendly: try rawArrival.parsable(required: "forInvalid")
            )
            let arrival = Arrival(
                transport: transport,
                time: try rawArrival.parsable(required: "time"),
                timeInSeconds: try rawArrival.parsable(required: "timeInSeconds"),
                nextStopName: try rawArrival.castable(required: "nextStopName"),
                nextStopId: try rawArrival.parsable(required: "nextStopId"),
                remainingLength: try rawArrival.parsable(required: "remainingLength"),
                spanLength: try rawArrival.parsable(required: "spanLength"),
                requestedStopId: try rawArrival.parsable(required: "requestedStopId")
            )
            arrivals.append(arrival)
        }
        
        return arrivals
    }
}
