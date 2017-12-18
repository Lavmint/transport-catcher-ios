//
//  LocalizedString.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import Foundation

enum LocalizedString {
    
    enum Arrival {
        
        static var minutesShort: String {
            return NSLocalizedString("arrival_minutesShort", comment: "")
        }
        
        static var metersLeftToStop: String {
            return NSLocalizedString("arrival_metersLeftToStop", comment: "")
        }
        
        static var invalidFriendly: String {
            return NSLocalizedString("arrival_invalidFriendly", comment: "")
        }
        
        static var emptyList: String {
            return NSLocalizedString("arrival_emptyList", comment: "")
        }
        
        static var selectStop: String {
            return NSLocalizedString("arrival_selectStop", comment: "")
        }
    }
    
    enum Alert {
        static var OK: String {
            return NSLocalizedString("alert_ok", comment: "")
        }
        
        static var Cancel: String {
            return NSLocalizedString("alert_cancel", comment: "")
        }
    }
    
    enum Settings {
        
        static var setTimeoutInterval: String {
            return NSLocalizedString("settings_setTimeoutInterval", comment: "")
        }
    }
    
    enum Common {
        
        static var value: String {
            return NSLocalizedString("common_value", comment: "")
        }
    }
    
    enum Transport {
        
        static var tramway: String {
            return NSLocalizedString("transport_tramway", comment: "")
        }
        
        static var trolleybus: String {
            return NSLocalizedString("transport_trolleybus", comment: "")
        }
        
        static var bus: String {
            return NSLocalizedString("transport_bus", comment: "")
        }
    }
}
