//
//  Locale.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 18/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension Locale {
    
    enum IdentifierType {
        case ru
        case en
    }
    
    var identifierType: IdentifierType {
        switch self.identifier {
        case "ru_US":
            return .ru
        default:
            return .en
        }
    }
    
}
