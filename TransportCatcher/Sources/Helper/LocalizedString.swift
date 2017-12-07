//
//  LocalizedString.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 24/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

enum LocalizedString {
    
    enum Arrival {
        
//        static func minutes(minutes: Int) -> String {
//            let lastDigit = minutes % 10
//            switch lastDigit {
//            case 1:
//                return "минута"
//            case 2...4:
//                return "минуты"
//            case 0, 5...9:
//                return "минут"
//            default:
//                assertionFailure()
//                return ""
//            }
//        }
        
        static var minutesShort: String {
            return "мин."
        }
        
        static var metersLeftToStop: String {
            return "м. до остановки"
        }
        
        static var invalidFriendly: String {
            return "Доступен для людей с ограниченными возможностями"
        }
        
        static var emptyList: String {
            return "По данным сервиса, прибытие транспорта на остановку в ближайшее время не ожидается."
        }
        
        static var selectStop: String {
            return "Выберите на карте остановку чтобы отобразить прибытие транспорта."
        }
    }
    
    enum Alert {
        static var OK: String {
            return "OK"
        }
        
        static var Cancel: String {
            return "Отменить"
        }
    }
    
    enum Settings {
        
        static var setTimeoutInterval: String {
            return "Введите время ожидания ответа от сервиса в секундах"
        }
    }
    
    enum Common {
        
        static var value: String {
            return "значение"
        }
    }
}
