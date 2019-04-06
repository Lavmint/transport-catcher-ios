//
//  TransportStop.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 25/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public struct TransportStop {
    public let id: Int
    public let name: String
    public let nameEn: String
    public let adjacentStreet: String
    public let adjacentStreetEn: String
    public let direction: String
    public let directionEn: String
    public let cluster: String
    public let busesMunicipal: String
    public let busesCommercial: String
    public let busesPrigorod: String
    public let busesSeason: String
    public let busesSpecial: String
    public let tramways: String
    public let trolleybuses: String
    public let metros: String
    public let hasTimeBoard: Bool
    public let latitude: Double
    public let longitude: Double
    public let angle: Int?
}
