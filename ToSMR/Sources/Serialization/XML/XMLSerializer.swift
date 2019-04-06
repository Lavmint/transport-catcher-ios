//
//  XMLSerializer.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal final class XMLSerializer: Serializer {
    
    internal func object<T>(from data: Data?) -> T? {
        
        guard let data = data else { return nil }
        
        do {
            if T.self == [TransportStop].self { return try stops(from: data) as! T? }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    internal func stops(from data: Data) throws -> [TransportStop]? {
        
        let adapter = XMLParserDictionaryAdapter(
            data: data,
            entityName: "stop",
            entityElements: [
                "KS_ID", "title", "titleEn", "adjacentStreet", "adjacentStreetEn", "direction", "directionEn", "cluster",
                "busesMunicipal", "busesCommercial", "busesPrigorod", "busesSeason", "busesSpecial",
                "trams", "trolleybuses", "metros", "infotabloExists", "latitude", "longitude", "angle"
            ]
        )
        let rawStops: [[String: String]] = try adapter.getResults()
        
        var stops: [TransportStop] = []
        for rawStop in rawStops {
            let stop = TransportStop(
                id: try rawStop.parsable(required: "KS_ID"),
                name: try rawStop.castable(required: "title"),
                nameEn: try rawStop.castable(required: "titleEn"),
                adjacentStreet: try rawStop.castable(required: "adjacentStreet"),
                adjacentStreetEn: try rawStop.castable(required: "adjacentStreetEn"),
                direction: try rawStop.castable(required: "direction"),
                directionEn: try rawStop.castable(required: "directionEn"),
                cluster: try rawStop.castable(required: "cluster"),
                busesMunicipal: try rawStop.castable(required: "busesMunicipal"),
                busesCommercial: try rawStop.castable(required: "busesCommercial"),
                busesPrigorod: try rawStop.castable(required: "busesPrigorod"),
                busesSeason: try rawStop.castable(required: "busesSeason"),
                busesSpecial: try rawStop.castable(required: "busesSpecial"),
                tramways: try rawStop.castable(required: "trams"),
                trolleybuses: try rawStop.castable(required: "trolleybuses"),
                metros: try rawStop.castable(required: "metros"),
                hasTimeBoard: try rawStop.castable(required: "infotabloExists") == "нет" ? false : true,
                latitude: try rawStop.parsable(required: "latitude"),
                longitude: try rawStop.parsable(required: "longitude"),
                angle: try rawStop.parsable(optional: "angle")
            )
            stops.append(stop)
        }
        return stops
    }
}

extension XMLSerializer {
    
    internal func data<T>(from object: T?) -> Data? {
        return nil
    }
}
