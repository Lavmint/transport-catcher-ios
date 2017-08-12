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
    
    internal func castable<T>(requiredField field: String) throws -> T {
        guard let value = self[field] else {
            throw UnwrapError.valueNotFound(msg: field)
        }
        guard let casted = value as? T else {
            throw UnwrapError.valueNotCasted(msg: "failed to cast value: \(value) to type: \(T.self)")
        }
        return casted
    }
    
    internal func castable<T>(optionalField field: String) throws -> T? {
        guard let value = self[field] else {
            return nil
        }
        guard let casted = value as? T else {
            throw UnwrapError.valueNotCasted(msg: "failed to cast value: \(value) to type: \(T.self)")
        }
        return casted
    }
    
    internal func parsable<T: Parsable>(requiredField field: String) throws -> T {
        let value: String = try castable(requiredField: field)
        guard !value.isNullOrEmpty, let parsed = T.parse(string: value) else {
            throw UnwrapError.valueNotParsed(msg: "failed to parse value: \(value) to type: \(T.self)")
        }
        return parsed as! T
    }
    
    internal func parsable<T: Parsable>(optionalField field: String) throws -> T? {
        guard let value: String = try castable(optionalField: field) else {
            return nil
        }
        guard !value.isNullOrEmpty, let parsed = T.parse(string: value) else {
            throw UnwrapError.valueNotParsed(msg: "failed to parse value: \(value) to type: \(T.self)")
        }
        return parsed as? T
    }
    
    internal func enumeration<T: RawRepresentable>(requiredField field: String) throws -> T {
        let value: T.RawValue = try castable(requiredField: field)
        guard let ecase = T(rawValue: value) else {
            throw UnwrapError.valueNotEnum(msg: "failed to make enum from value: \(value) to type: \(T.self)")
        }
        return ecase
    }
    
    internal func enumeration<T: RawRepresentable>(optionalField field: String) throws -> T? {
        guard let value: T.RawValue = try castable(optionalField: field) else {
            return nil
        }
        guard let ecase = T(rawValue: value) else {
            throw UnwrapError.valueNotEnum(msg: "failed to make enum from value: \(value) to type: \(T.self)")
        }
        return ecase
    }
}


