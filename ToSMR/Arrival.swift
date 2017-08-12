//
//  Arrivale.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 09/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

public struct Arrival {
    
    public let transport: Transport
    
    /// time — время до прибытия транспорта на остановку;
    public let time: Int
    
    /// timeInSeconds — время до прибытия транспорта на остановку в секундах;
    public let timeInSeconds: Double
    
    /// nextStopName — название следующей остановки;
    public let nextStopName: String
    
    /// remainingLength — оставшаяся часть пути (в метрах);
    public let remainingLength: Double
    
    /// remainingLength — оставшаяся часть пути (в метрах);
    public let spanLength: Double
    
    /// requestedStopId — классификаторный номер остановки, для которой запрошен прогноз (помогает разобраться при запросе на несколько остановок сразу);
    public let requestedStopId: Int
}
