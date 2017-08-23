//
//  Transport.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 09/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public enum TransportType: String {
    case bus = "Автобус"
    case trolleybus = "Троллейбус"
    case tramway = "Трамвай"
}

public struct Transport {
    
    /// type — тип транспорта;
    public let type: TransportType
    
    /// номер маршрута, например 21к
    public let number: String
    
    /// классификаторный номер маршрута.
    public let route: Int
    
    /// hullNo — идентификатор транспорта;
    public let hullNumber: Int
    
    /// stateNumber — номер госрегистрации;
    public let stateNumber: String
    
    /// modelTitle — название модели транспорта;
    public let model: String?
    
    /// forInvalid — флаг доступности для людей с ограниченными возможностями;
    public let isInvalidFriendly: Bool
}
