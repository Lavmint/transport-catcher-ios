//
//  RequestManager.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 08/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

public struct ToSamaraService {
    
    public struct CompletionBox<T> {
        var data: T?
        var response: URLResponse?
        var error: Error?
    }
    
    fileprivate struct Parameter {
        var key: String
        var value: Any?
        var isSignatureComponent: Bool
    }
    
    fileprivate static var shared: ToSamaraService?
    
    public static func configure(clientId: String, secret: String) {
        shared = ToSamaraService(clientId: clientId, secret: secret)
    }

    public let clientId: String
    public let secret: String
    
    private init(clientId: String, secret: String) {
        self.clientId = clientId
        self.secret = secret
    }
    
    fileprivate func url(method: String, query: String) -> URL? {
        let scheme = "http"
        let host = "tosamara.ru"
        let path = "/api/json"
        var rawUrl = scheme + "://" + host + path
        rawUrl += query.characters.count > 0 ? "?" + query : ""
        guard let url = URL(string: rawUrl) else {
            return nil
        }
        return url
    }
    
    fileprivate func query(from params: [String: Any]) -> String {
        
        var parameters = params
        parameters.updateValue("ios", forKey: "os")
        parameters.updateValue(clientId, forKey: "clientid")
        
        var urlParameters = ""
        for (idx, parameter) in parameters.enumerated() {
            urlParameters += "\(parameter.key)=\(parameter.value)"
            if idx < parameters.count - 1 {
                urlParameters += "&"
            }
        }
        
        return urlParameters
    }
    
    fileprivate func request(method: String, with parameters: [Parameter]) -> URLRequest? {
        
        guard let service = ToSamaraService.shared else {
            return nil
        }
        
        guard let url = service.url(method: method, query: service.query(from: signed(parameters: parameters))) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.cachePolicy = .useProtocolCachePolicy
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "content-type": "application/json"
        ]
        return request
    }
    
    fileprivate func signed(parameters: [Parameter]) -> [String: Any] {
        
        var signedParameters: [String: Any] = [:]
        var signatureComponents: [String] = []
        
        for parameter in parameters {
            guard let value = parameter.value else { continue }
            signedParameters.updateValue(value, forKey: parameter.key)
            guard parameter.isSignatureComponent else { continue }
            signatureComponents.append(String(describing: value))
        }
        
        let authKey = signatureComponents.joined().sha1
        signedParameters.updateValue(authKey, forKey: "authKey")
        return signedParameters
    }
}

extension ToSamaraService {
    
    /// Метод получения прогнозов прибытия транспорта на выбранную остановку. Возможен запрос на несколько остановок сразу, в таком случае результаты упорядочиваются по времени прибытия.
    ///
    /// - Parameters:
    ///   - ksId: классификаторный номер остановки
    ///   - count: количество ближайших прибывающих маршрутов (необязательный параметр)
    public static func approximateArrivale(toStop ksId: Int, limitation count: Int? = nil, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
    
        let parameters: [Parameter] = [
            Parameter(key: "KS_ID", value: ksId, isSignatureComponent: true),
            Parameter(key: "COUNT", value: count, isSignatureComponent: true)
        ]

        guard let request = shared?.request(method: "getFirstArrivalToStop", with: parameters) else {
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
    
    public static func approximateArrivale(ofRoute krId: Int, toStop ksId: Int, completion: @escaping (CompletionBox<[Arrival]>) -> Void) {
        
    }
}
