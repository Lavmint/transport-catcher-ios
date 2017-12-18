//
//  NSObject.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 01/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var stringClass: String {
        return String.init(describing: self)
    }
}
