//
//  Optional.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 12/08/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

enum OptionalError: Error {
    case valueRequired
}

extension Optional {
    
    func required() throws -> Wrapped {
        guard let val = self else {
            throw OptionalError.valueRequired
        }
        return val
    }
}
