//
//  TransportStop.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 18/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension TransportStop {
    
    var localizedName: String? {
        return Locale.current.identifierType == .ru ? name : nameEn
    }
    
    var localizedDirection: String? {
        return Locale.current.identifierType == .ru ? direction : directionEn
    }
    
    var localizedAdjacentStreet: String? {
        return Locale.current.identifierType == .ru ? adjacentStreet : adjacentStreetEn
    }
}
