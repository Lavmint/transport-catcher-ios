//
//  RequestManager.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

public enum Result<T> {
    case succeed(T?)
    case error(Error)
    
    public enum Error: Swift.Error, LocalizedError {
        case client(error: Swift.Error)
        case server(error: (Int, String))
        case unexpected
        
        public var errorDescription: String? {
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
            result = Result.error(Result.Error.server(error: (error.code, error.message)))
        } else if let error = foundationError {
            result = Result.error(Result.Error.client(error: error))
        } else {
            result = Result.error(Result.Error.unexpected)
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
    public let serializer: Serializer
    public let baseURL: String
    
    private let xmlSerializer: XMLSerializer
    
    public init(clientId: String, secret: String, serializer: Serializer = JSONSerializer()) {
        self.clientId = clientId
        self.secret = secret
        self.serializer = serializer
        self.xmlSerializer = XMLSerializer()
        self.baseURL = "http://tosamara.ru/api"
    }
    
    /// Метод получения прогнозов прибытия транспорта на выбранную остановку. Возможен запрос на несколько остановок сразу, в таком случае результаты упорядочиваются по времени прибытия.
    ///
    /// - Parameters:
    ///   - ksId: классификаторный номер остановки
    ///   - count: количество ближайших прибывающих маршрутов (необязательный параметр)
    public func approximateArrivals(toStop ksId: Int, limitation count: Int? = nil, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
        let parameters: [Parameter] = [
            Parameter(key: "KS_ID", value: ksId, isSignatureComponent: true),
            Parameter(key: "COUNT", value: count, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraJSONRequest(baseURL: baseURL, method: "getFirstArrivalToStop", parameters: parameters, clientId: clientId, secret: secret) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let object: [Arrival]? = self?.serializer.object(from: data)
            DispatchQueue.main.async {
                let box = CompletionBox<[Arrival]>(request: request, data: object, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    /// Метод получения информации о прибытии транспортных средств выбранного маршрута на выбранную остановку.
    ///
    /// - Parameters:
    ///   - krId: классификаторный номер маршрута.
    ///   - ksId: классификаторный номер остановки;
    public func approximateArrivals(ofRoute krId: Int, toStop ksId: Int, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
        let parameters: [Parameter] = [
            Parameter(key: "KR_ID", value: krId, isSignatureComponent: true),
            Parameter(key: "KS_ID", value: ksId, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraJSONRequest(baseURL: baseURL, method: "getRouteArrivalToStop", parameters: parameters, clientId: clientId, secret: secret) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let object: [Arrival]? = self?.serializer.object(from: data)
            DispatchQueue.main.async {
                let box = CompletionBox<[Arrival]>(request: request, data: object, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    /// Метод дает информацию о положении транспортов в окрестности пользователя.
    ///
    /// - Parameters:
    ///   - radius: радиус поиска в метрах;
    ///   - longitude: координата пользователя в WGS 84;
    ///   - latitude: координата пользователя в WGS 84;
    ///   - count: максимальное количество возвращаемых результатов.
    public func transports(inRadius radius: Double, atLongitude longitude: Double, atLatitude latitude: Double, limitation count: Int, completion: @escaping (CompletionBox<[Transport]>) -> Void) {
        
        let parameters: [Parameter] = [
            Parameter(key: "LATITUDE", value: latitude, isSignatureComponent: true),
            Parameter(key: "LONGITUDE", value: longitude, isSignatureComponent: true),
            Parameter(key: "RADIUS", value: radius, isSignatureComponent: true),
            Parameter(key: "COUNT", value: count, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraJSONRequest(baseURL: baseURL, method: "getSurroundingTransports", parameters: parameters, clientId: clientId, secret: secret) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let object: [Transport]? = self?.serializer.object(from: data)
            DispatchQueue.main.async {
                let box = CompletionBox<[Transport]>(request: request, data: object, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    /// Метод дает информацию о положении транспортов на указанных маршрутах.
    ///
    /// - Parameters:
    ///   - routes: классификаторный номер маршрута (возможно, несколько);
    ///   - count: максимальное количество возвращаемых результатов.
    public func transports(onRoutes routes: [Int], limitation count: Int, completion: @escaping (CompletionBox<[Transport]>) -> Void) {
        
        let parameters: [Parameter] = [
            Parameter(key: "KR_ID", value: routes.map({ String($0)}).joined(separator: ","), isSignatureComponent: true),
            Parameter(key: "COUNT", value: count, isSignatureComponent: true)
        ]
        
        guard let request = URLRequest.toSamaraJSONRequest(baseURL: baseURL, method: "getTransportsOnRoute", parameters: parameters, clientId: clientId, secret: secret) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let object: [Transport]? = self?.serializer.object(from: data)
            DispatchQueue.main.async {
                let box = CompletionBox<[Transport]>(request: request, data: object, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
    
    /**
     Классификатор остановок с координатами
     Расширенная версия классификатора остановок, включающая географические координаты и перечисления проходящих маршрутов. Именно она используется в «Прибывалках». Хранится в документе формата XML по адресу tosamara.ru/api/classifiers/stopsFullDB.xml и имеет следующую структуру:
     */
    public func stops(completion: @escaping (CompletionBox<[TransportStop]>) -> Void) {
        guard let url = URL(string: baseURL + "/classifiers/stopsFullDB.xml") else { return }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            let object: [TransportStop]? = self?.xmlSerializer.object(from: data)
            DispatchQueue.main.async {
                let box = CompletionBox<[TransportStop]>(request: request, data: object, response: response, error: error)
                completion(box)
            }
        }
        dataTask.resume()
    }
}
