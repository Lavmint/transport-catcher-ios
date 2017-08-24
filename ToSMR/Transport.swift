//
//  Transport.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 09/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public struct Transport {
    
    /// направление движения транспорта в точке, где он сейчас находится, в градусах от 0 до 360 по тригонометрическому
    public let direction: Double
    
    /// номер маршрута, например 21к
    public let number: String
    
    /// классификаторный номер маршрута.
    public let route: Int
    
    /// modelTitle — название модели транспорта;
    public let model: String?
    
    /// hullNo — идентификатор транспорта;
    public let hullNumber: Int
    
    /// nextStopId - классификаторный номер остановки
    public let nextStopId: Int
    
    /// stateNumber — номер госрегистрации;
    public let stateNumber: String
    
    /// forInvalid — флаг доступности для людей с ограниченными возможностями;
    public let isInvalidFriendly: Bool
    
    /// type — тип транспорта;
    public let type: TransportType
    
    /// широта, координаты транспорта в WGS 84;
    public let latitude: Double
    
    /// долгота, координаты транспорта в WGS 84;
    public let longitude: Double
}
