//
//  Optional.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

internal enum OptionalError: Error {
    case valueRequired
}

internal extension Optional {
    
    internal func required() throws -> Wrapped {
        guard let val = self else {
            throw OptionalError.valueRequired
        }
        return val
    }
}
