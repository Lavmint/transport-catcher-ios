//
//  Parsable.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

protocol Parsable {
    associatedtype Value: Hashable
    static func parse(string: String) -> Value?
}

extension Int: Parsable {
    
    static func parse(string: String) -> Int? {
        return Int(string)
    }
}

extension Double: Parsable {
    
    static func parse(string: String) -> Double? {
        return Double(string)
    }
}

extension Bool: Parsable {
    
    static func parse(string: String) -> Bool? {
        return Bool(string)
    }
}
