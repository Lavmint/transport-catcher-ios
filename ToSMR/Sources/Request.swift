//
//  ToSamaraRequest.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 11/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal extension URLRequest {
 
    static func toSamaraJSONRequest(baseURL: String, method: String, parameters: [Service.Parameter], clientId: String, secret: String, timeoutInterval: TimeInterval = 20) -> URLRequest? {
        
        func makeURL(query: String) -> URL? {
            var rawUrl = baseURL + "/json"
            rawUrl += query.count > 0 ? "?" + query : ""
            guard let url = URL(string: rawUrl) else {
                return nil
            }
            return url
        }
        
        func makeQuery(from params: [String: Any], with clientId: String) -> String {
            
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
        
        func sign(parameters: [Service.Parameter], with secret: String) -> [String: Any] {
            
            var signedParameters: [String: Any] = [:]
            var signatureComponents: [String] = []
            
            for parameter in parameters {
                guard let value = parameter.value else { continue }
                signedParameters.updateValue(value, forKey: parameter.key)
                guard parameter.isSignatureComponent else { continue }
                signatureComponents.append(String(describing: value))
            }
            
            signatureComponents.append(secret)
            let authKey = signatureComponents.joined().sha1
            signedParameters.updateValue(authKey, forKey: "authkey")
            return signedParameters
        }
        
        let method = Service.Parameter(key: "method", value: method, isSignatureComponent: false)
        let signedParameters = sign(parameters: [method] + parameters, with: secret)
        let query = makeQuery(from: signedParameters, with: clientId)
        guard let url = makeURL(query: query) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval
        request.cachePolicy = .useProtocolCachePolicy
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "content-type": "application/json"
        ]
        return request
    }
}
