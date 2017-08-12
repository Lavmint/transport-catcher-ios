//
//  RequestManager.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

public final class Service {
    
    public struct CompletionBox<T> {
        
        public let result: T?
        public let httpResponse: HTTPURLResponse?
        public let error: Error?
        
        internal init(data: T?, response: URLResponse?, error: Error?) {
            self.result = data
            self.httpResponse = response as? HTTPURLResponse
            self.error = error
        }
    }
    
    internal struct Parameter {
        var key: String
        var value: Any?
        var isSignatureComponent: Bool
    }

    public let clientId: String
    public let secret: String
    
    public init(clientId: String, secret: String) {
        self.clientId = clientId
        self.secret = secret
    }
    
    /// Метод получения прогнозов прибытия транспорта на выбранную остановку. Возможен запрос на несколько остановок сразу, в таком случае результаты упорядочиваются по времени прибытия.
    ///
    /// - Parameters:
    ///   - ksId: классификаторный номер остановки
    ///   - count: количество ближайших прибывающих маршрутов (необязательный параметр)
    public func approximateArrivale(toStop ksId: Int, limitation count: Int? = nil, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
        let parameters: [Parameter] = [
            Parameter(key: "KS_ID", value: ksId, isSignatureComponent: true),
            Parameter(key: "COUNT", value: count, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraRequest(method: "getFirstArrivalToStop", parameters: parameters, clientId: clientId, secret: secret) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                let box = CompletionBox<[Arrival]>(data: nil, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    public func approximateArrivale(ofRoute krId: Int, toStop ksId: Int, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
    }
}
