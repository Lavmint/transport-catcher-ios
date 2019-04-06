//
//  SettingsInteractor.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 07/12/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import ToSMR

class SettingsInteractor {
    
    let userStorage: UserStorage
    
    init() {
        userStorage = UserStorage(context: TransportCatcherPersistenseContainer.shared.viewContext)
    }
    
    var timeoutInterval: TimeInterval {
        get {
            return Service.shared.timeoutInterval
        }
        set {
            userStorage.standard.timeoutInteraval = newValue
            Service.shared.timeoutInterval = newValue
        }
    }
}
