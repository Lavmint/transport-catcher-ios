//
//  TransportStopStorage.swift
//  TransportCatcher
//
//  Created by Alexey Averkin on 30/11/2017.
//  Copyright © 2017 Alexey Averkin. All rights reserved.
//

import CoreData

class TransportStopStorage: Storage {

    typealias PrimaryKey = Int
    typealias Object = TransportStop
    var primaryKeyName: String {
        return "id"
    }
    
    let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = ClassifierPersistenseContainer.shared.viewContext
    }
}
