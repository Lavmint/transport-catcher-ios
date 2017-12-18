//
//  Date.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 03/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

extension Date {
    
    static var dateAWeekAgo: Date! {
        let now = Date()
        return Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: now)
    }
    
    func isBetween(d1: Date, d2: Date) -> Bool {
        return self.timeIntervalSince1970.isBetween(i1: d1.timeIntervalSince1970, i2: d2.timeIntervalSince1970)
    }
}

extension TimeInterval {
    
    func isBetween(i1: TimeInterval, i2: TimeInterval) -> Bool {
        return i1 <= self && self <= i2
    }
}
