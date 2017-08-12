//
//  RequestManager.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

public enum Error {
    case client(error: Swift.Error)
    case server(error: (Int, String))
    case unexpected
    
    public var localizedDescription: String {
        switch self {
        case .client(error: let error):
            return error.localizedDescription
        case .server(error: (_, let msg)):
            return msg
        case .unexpected:
            let bundle = Bundle(for: Service.self)
            return "Unexpected error occured in module: \(bundle.bundleIdentifier ?? "")"
        }
    }
}

public enum Result<T> {
    case succeed(T?)
    case error(Error)
}

public struct CompletionBox<T> {
    
    public let request: URLRequest
    public let response: HTTPURLResponse?
    public let result: Result<T>
    
    internal init(request: URLRequest, data: T?, response: URLResponse?, error foundationError: Swift.Error?) {
        self.request = request
        self.response = response as? HTTPURLResponse
        
        guard self.response?.statusCode != 200 else {
            result = Result.succeed(data)
            return
        }
        
        if let error = self.response?.error {
            result = Result.error(Error.server(error: (error.code, error.message)))
        } else if let error = foundationError {
            result = Result.error(Error.client(error: error))
        } else {
            result = Result.error(Error.unexpected)
        }
    }
}

public final class Service {
    
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
                let box = CompletionBox<[Arrival]>(request: request, data: nil, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    public func approximateArrivale(ofRoute krId: Int, toStop ksId: Int, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
    }
}
