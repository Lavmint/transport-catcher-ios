//
//  Arrivale.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 09/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public struct Arrival {
    
    /// классификаторный номер маршрута.
    public let routeId: Int
    
    /// type — тип транспорта;
    public let type: TransportType
    
    /// номер маршрута, например 21к
    public let route: String
    
    /// modelTitle — название модели транспорта;
    public let model: String?
    
    /// stateNumber — номер госрегистрации;
    public let stateNumber: String
    
    /// hullNo — идентификатор транспорта;
    public let hullNumber: Int
    
    /// forInvalid — флаг доступности для людей с ограниченными возможностями;
    public let isInvalidFriendly: Bool
    
    /// requestedStopId — классификаторный номер остановки, для которой запрошен прогноз (помогает разобраться при запросе на несколько остановок сразу);
    public let requestedStopId: Int
    
    /// nextStopId - классификаторный номер остановки
    public let nextStopId: Int
    
    /// nextStopName — название следующей остановки;
    public let nextStopName: String
    
    /// time — время до прибытия транспорта на остановку;
    public let time: Int
    
    /// timeInSeconds — время до прибытия транспорта на остановку в секундах;
    public let timeInSeconds: Double
    
    /// remainingLength — оставшаяся часть пути (в метрах);
    public let remainingLength: Double
    
    /// remainingLength — оставшаяся часть пути (в метрах);
    public let spanLength: Double
}
