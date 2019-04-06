//
//  JSONSerializer.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

public final class JSONSerializer: Serializer {
    
    public init () { }
    
    public func data<T>(from object: T?) -> Data? {
        return nil
    }
}

// MARK: Deserialization
public extension JSONSerializer {
 
    func object<T>(from data: Data?) -> T? {
        
        guard let data = data else { return nil }

        do {
            if T.self == [Arrival].self { return try arrivals(from: data) as! T? }
            if T.self == [Transport].self { return try transports(from: data) as! T? }
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
            let arrival = Arrival(
                routeId: try rawArrival.parsable(required: "KR_ID"),
                type: try rawArrival.enumeration(required: "type"),
                route: try rawArrival.castable(required: "number"),
                model: try rawArrival.castable(optional: "modelTitle"),
                stateNumber: try rawArrival.castable(required: "stateNumber"),
                hullNumber: try rawArrival.parsable(required: "hullNo"),
                isInvalidFriendly: try rawArrival.parsable(required: "forInvalid"),
                requestedStopId: try rawArrival.parsable(required: "requestedStopId"),
                nextStopId: try rawArrival.parsable(required: "nextStopId"),
                nextStopName: try rawArrival.castable(required: "nextStopName"),
                time: try rawArrival.parsable(required: "time"),
                timeInSeconds: try rawArrival.parsable(required: "timeInSeconds"),
                remainingLength: try rawArrival.parsable(required: "remainingLength"),
                spanLength: try rawArrival.parsable(required: "spanLength")
            )
            arrivals.append(arrival)
        }
        
        return arrivals
    }
    
    internal func transports(from data: Data) throws -> [Transport]? {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        let dictionary: [String: Any] = try (jsonObject as? [String: Any]).required()
        let rawTransports: [[String: Any]] = try dictionary.castable(required: "transports")
        
        var transports: [Transport] = []
        for rawTransport in rawTransports {
            let transport = Transport(
                direction: try rawTransport.parsable(required: "direction"),
                number: try rawTransport.castable(required: "number"),
                route: try rawTransport.parsable(required: "KR_ID"),
                model: try rawTransport.castable(optional: "modelTitle"),
                hullNumber: try rawTransport.parsable(required: "hullNo"),
                nextStopId: try rawTransport.parsable(required: "nextStopId"),
                stateNumber: try rawTransport.castable(required: "stateNumber"),
                isInvalidFriendly: try rawTransport.parsable(required: "forInvalid"),
                type: try rawTransport.enumeration(required: "type"),
                latitude: try rawTransport.parsable(required: "latitude"),
                longitude: try rawTransport.parsable(required: "longitude")
            )
            transports.append(transport)
        }
        
        return transports
    }
}
