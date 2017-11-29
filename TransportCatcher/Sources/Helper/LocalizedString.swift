//
//  LocalizedString.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

enum LocalizedString {
    
    enum Arrival {
        
        static func minutes(minutes: Int) -> String {
            let lastDigit = minutes % 10
            switch lastDigit {
            case 1:
                return "минута"
            case 2...4:
                return "минуты"
            case 0, 5...9:
                return "минут"
            default:
                assertionFailure()
                return ""
            }
        }
        
        static var metersLeftToStop: String {
            return "м. до остановки"
        }
        
        static var invalidFriendly: String {
            return "Доступен для людей с ограниченными возможностями"
        }
    }
    
    enum Alert {
        static var OK: String {
            return "OK"
        }
    }
}
