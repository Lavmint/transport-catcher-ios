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
        if self.identifier.contains("ru") { return .ru }
        return .en
    }
    
}
