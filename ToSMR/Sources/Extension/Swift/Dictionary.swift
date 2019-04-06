//
//  Dictionary.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal enum UnwrapError: Error {
    case valueNotFound(msg: String)
    case valueNotCasted(msg: String)
    case valueNotParsed(msg: String)
    case valueNotEnum(msg: String)
}

extension Dictionary where Key == String {
    
    internal func castable<T>(required field: String) throws -> T {
        guard let value = self[field] else {
            throw UnwrapError.valueNotFound(msg: field)
        }
        guard let casted = value as? T else {
            throw UnwrapError.valueNotCasted(msg: "failed to cast value: \(value) to type: \(T.self) in field: \(field)")
        }
        return casted
    }
    
    internal func castable<T>(optional field: String) throws -> T? {
        guard let value = self[field], !(value is NSNull) else { return nil }
        guard let casted = value as? T else {
            throw UnwrapError.valueNotCasted(msg: "failed to cast value: \(value) to type: \(T.self) in field: \(field)")
        }
        return casted
    }
    
    internal func parsable<T: Parsable>(required field: String) throws -> T {
        let value: String = try castable(required: field)
        guard !value.isNullOrEmpty, let parsed = T.parse(string: value) else {
            throw UnwrapError.valueNotParsed(msg: "failed to parse value: \(value) to type: \(T.self) in field: \(field)")
        }
        return parsed as! T
    }
    
    internal func parsable<T: Parsable>(optional field: String) throws -> T? {
        guard let value: String = try castable(optional: field), !value.isEmpty else {
            return nil
        }
        guard !value.isNullOrEmpty, let parsed = T.parse(string: value) else {
            throw UnwrapError.valueNotParsed(msg: "failed to parse value: \(value) to type: \(T.self) in field: \(field)")
        }
        return parsed as? T
    }
    
    internal func enumeration<T: RawRepresentable>(required field: String) throws -> T {
        let value: T.RawValue = try castable(required: field)
        guard let ecase = T(rawValue: value) else {
            throw UnwrapError.valueNotEnum(msg: "failed to make enum from value: \(value) to type: \(T.self) in field: \(field)")
        }
        return ecase
    }
    
    internal func enumeration<T: RawRepresentable>(optional field: String) throws -> T? {
        guard let value: T.RawValue = try castable(optional: field) else {
            return nil
        }
        guard let ecase = T(rawValue: value) else {
            throw UnwrapError.valueNotEnum(msg: "failed to make enum from value: \(value) to type: \(T.self) in field: \(field)")
        }
        return ecase
    }
}


